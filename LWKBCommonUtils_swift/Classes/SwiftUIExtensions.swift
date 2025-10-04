//
//  SwiftUIExtensions.swift
//  LWKBCommonUtils
//
//  Created by Luo Wei
//  Copyright (c) 2017 luowei. All rights reserved.
//

import SwiftUI

// MARK: - Device Info for SwiftUI

@available(iOS 13.0, *)
public struct DeviceInfo {
    public static var screenWidth: CGFloat {
        return Screen.width
    }

    public static var screenHeight: CGFloat {
        return Screen.height
    }

    public static var isIPad: Bool {
        return Device.isIPad
    }

    public static var isIPadPro: Bool {
        return Device.isIPadPro
    }

    public static var hasNotch: Bool {
        return Device.hasTopNotch
    }

    public static var safeContentHeight: CGFloat {
        return Device.exceptNotchHeight
    }
}

// MARK: - View Extensions

@available(iOS 13.0, *)
public extension View {

    /// Run a closure on the main thread safely
    func onMainThread(_ action: @escaping () -> Void) -> some View {
        self.modifier(MainThreadModifier(action: action))
    }

    /// Conditional view modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Apply modifier if condition is true
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }

    /// Hide view based on condition
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}

@available(iOS 13.0, *)
private struct MainThreadModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content.onAppear {
            dispatchMainSyncSafe(action)
        }
    }
}

// MARK: - Color Extensions

@available(iOS 13.0, *)
public extension Color {

    /// Create color from hex string
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - GeometryReader Helpers

@available(iOS 13.0, *)
public struct ScreenSize {
    public var width: CGFloat
    public var height: CGFloat
    public var isLandscape: Bool {
        return width > height
    }
    public var isPortrait: Bool {
        return !isLandscape
    }
}

@available(iOS 13.0, *)
public extension GeometryProxy {
    var screenSize: ScreenSize {
        return ScreenSize(width: size.width, height: size.height)
    }
}

// MARK: - Environment Values

@available(iOS 13.0, *)
public struct AppGroupKey: EnvironmentKey {
    public static let defaultValue: String? = nil
}

@available(iOS 13.0, *)
public extension EnvironmentValues {
    var appGroupId: String? {
        get { self[AppGroupKey.self] }
        set { self[AppGroupKey.self] = newValue }
    }
}

// MARK: - PropertyWrapper for UserDefaults/AppGroup Storage

@available(iOS 13.0, *)
@propertyWrapper
public struct AppStorage<Value> {
    private let key: String
    private let defaultValue: Value

    public var wrappedValue: Value {
        get {
            return (LWDataPipeManager.getValue(forKey: key) as? Value) ?? defaultValue
        }
        nonmutating set {
            LWDataPipeManager.setValue(newValue, forKey: key)
        }
    }

    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

@available(iOS 13.0, *)
@propertyWrapper
public struct AppGroupStorage<Value> {
    private let key: String
    private let defaultValue: Value

    public var wrappedValue: Value {
        get {
            return (LWDataPipeManager.getAppGroupValue(forKey: key) as? Value) ?? defaultValue
        }
        nonmutating set {
            LWDataPipeManager.setAppGroupValue(newValue, forKey: key)
        }
    }

    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

// MARK: - Debug Logging View Modifier

@available(iOS 13.0, *)
public extension View {
    func debugLog(_ items: Any...) -> some View {
        #if DEBUG
        Log(items)
        #endif
        return self
    }

    func debugPrint(_ value: Any) -> Self {
        #if DEBUG
        print(value)
        #endif
        return self
    }
}

// MARK: - Orientation Helper

@available(iOS 13.0, *)
public struct OrientationInfo {
    public var isLandscape: Bool
    public var isPortrait: Bool
    public var screenWidth: CGFloat
    public var screenHeight: CGFloat

    public static var current: OrientationInfo {
        let isLandscape = Screen.isLandscape
        return OrientationInfo(
            isLandscape: isLandscape,
            isPortrait: !isLandscape,
            screenWidth: Screen.width,
            screenHeight: Screen.height
        )
    }
}

// MARK: - Safe Area Helper

@available(iOS 13.0, *)
public struct SafeAreaInsetsKey: PreferenceKey {
    public static var defaultValue: EdgeInsets = EdgeInsets()

    public static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}

@available(iOS 13.0, *)
public extension View {
    func readSafeAreaInsets(_ insets: Binding<EdgeInsets>) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear.preference(
                    key: SafeAreaInsetsKey.self,
                    value: geometry.safeAreaInsets
                )
            }
        )
        .onPreferenceChange(SafeAreaInsetsKey.self) { value in
            insets.wrappedValue = value
        }
    }
}
