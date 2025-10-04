//
//  LWKBCommonUtils.swift
//  LWKBCommonUtils
//
//  Created by Luo Wei
//  Copyright (c) 2017 luowei. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Module Information

public struct LWKBCommonUtils {
    public static let version = "1.0.0"
    public static let name = "LWKBCommonUtils"

    /// Initialize the library with custom configuration
    public static func configure(appGroupId: String? = nil) {
        // Future configuration options can be added here
    }
}

// MARK: - Convenience Type Aliases

public typealias DataPipe = LWDataPipeManager

// MARK: - Global Utilities

/// Quick access to screen dimensions
public enum ScreenDimensions {
    public static var width: CGFloat { Screen.width }
    public static var height: CGFloat { Screen.height }
    public static var scale: CGFloat { Screen.scale }
    public static var isLandscape: Bool { Screen.isLandscape }
    public static var portraitWidth: CGFloat { Screen.portraitWidth }
    public static var portraitHeight: CGFloat { Screen.portraitHeight }
}

/// Quick access to device information
public enum DeviceType {
    public static var isIPad: Bool { Device.isIPad }
    public static var isIPadPro: Bool { Device.isIPadPro }
    public static var hasNotch: Bool { Device.hasTopNotch }
    public static var safeContentHeight: CGFloat { Device.exceptNotchHeight }
}

// MARK: - Common Extensions

public extension String {
    /// Check if string contains Chinese characters
    var hasChineseCharacters: Bool {
        return self.contains { isChineseSymbol($0) }
    }

    /// Check if all characters are Chinese
    var isAllChinese: Bool {
        return !self.isEmpty && self.allSatisfy { isChineseSymbol($0) }
    }
}

public extension Bundle {
    /// Get the app group ID from Info.plist
    var appGroupId: String? {
        return infoDictionary?["GroupId"] as? String
    }
}

// MARK: - Thread Safety Utilities

public extension DispatchQueue {
    /// Execute on main queue, immediately if already on main thread
    static func mainSyncSafe(_ block: @escaping () -> Void) {
        dispatchMainSyncSafe(block)
    }

    /// Execute on main queue asynchronously
    static func mainAsync(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
}

// MARK: - UserDefaults Convenience

public extension UserDefaults {
    /// Get app group shared defaults
    static func appGroup(suiteName: String = "group.com.wodedata.LWInputMethod") -> UserDefaults? {
        return UserDefaults(suiteName: suiteName)
    }
}

// MARK: - Weak/Strong Reference Helpers

/// Weak reference wrapper
public class Weak<T: AnyObject> {
    public weak var value: T?

    public init(_ value: T?) {
        self.value = value
    }
}

/// Execute closure with weak self
public func withWeakSelf<T: AnyObject>(_ object: T, _ closure: @escaping (T) -> Void) -> () -> Void {
    return { [weak object] in
        guard let object = object else { return }
        closure(object)
    }
}

// MARK: - Version Comparison Utilities

public extension String {
    /// Compare version strings (e.g., "1.2.3" vs "1.2.4")
    func compareVersion(to version: String) -> ComparisonResult {
        return self.compare(version, options: .numeric)
    }

    /// Check if this version is greater than another
    func isVersionGreaterThan(_ version: String) -> Bool {
        return compareVersion(to: version) == .orderedDescending
    }

    /// Check if this version is less than another
    func isVersionLessThan(_ version: String) -> Bool {
        return compareVersion(to: version) == .orderedAscending
    }

    /// Check if this version equals another
    func isVersionEqual(to version: String) -> Bool {
        return compareVersion(to: version) == .orderedSame
    }
}

// MARK: - CGFloat Utilities

public extension CGFloat {
    /// Scale value based on screen scale
    var scaled: CGFloat {
        return self * Screen.scale
    }

    /// Unscale value based on screen scale
    var unscaled: CGFloat {
        return self / Screen.scale
    }
}

// MARK: - CGRect Utilities

public extension CGRect {
    /// Get center point of rect
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
