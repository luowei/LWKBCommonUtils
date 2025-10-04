//
//  AppDefines.swift
//  MyInputMethod
//
//  Created by Luo Wei on 2017/5/16.
//  Copyright (c) 2017 luowei. All rights reserved.
//

import UIKit

// MARK: - System Version Comparison

public struct SystemVersion {
    public static func isEqual(to version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedSame
    }

    public static func isGreaterThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedDescending
    }

    public static func isGreaterThanOrEqual(to version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }

    public static func isLessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }

    public static func isLessThanOrEqual(to version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedDescending
    }
}

// MARK: - Logging

public func Log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items.map { "\($0)" }.joined(separator: separator), terminator: terminator)
    #endif
}

// MARK: - App Group ID

public var groupId: String? {
    return Bundle.main.infoDictionary?["GroupId"] as? String
}

// MARK: - Character Utilities

public func isChineseSymbol(_ char: Character) -> Bool {
    guard let scalar = char.unicodeScalars.first else { return false }
    return scalar.value > 127
}

// MARK: - Threading Utilities

public func dispatchMainSyncSafe(_ block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync(execute: block)
    }
}

// MARK: - Screen Properties

public struct Screen {
    public static var scale: CGFloat {
        return UIScreen.main.scale
    }

    public static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    public static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    public static var isLandscape: Bool {
        return width > height
    }

    public static var portraitWidth: CGFloat {
        return width > height ? height : width
    }

    public static var portraitHeight: CGFloat {
        return width > height ? width : height
    }
}

// MARK: - Device Properties

public struct Device {
    public static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isIPadPro: Bool {
        guard isIPad else { return false }
        let maxDimension = max(Screen.width, Screen.height)
        return maxDimension == 1112.0 || maxDimension == 1194.0 || maxDimension == 1366.0
    }

    public static var hasTopNotch: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.size.height >= 812.0
        }
        return false
    }

    public static var exceptNotchHeight: CGFloat {
        if hasTopNotch {
            return Screen.height - 108
        } else if isIPadPro {
            return Screen.height - 48
        } else {
            return Screen.height
        }
    }
}

// MARK: - Constants

public struct AppConstants {
    public static let afterDateReview = "2020-07-03"

    public static var prefsURLString: String {
        return "pre" + "fs:ro" + "ot=General&path=Keyboard/KEYBOARDS"
    }

    public static var prefsURLStringiOS10: String {
        return "App-Pre" + "fs:ro" + "ot=General&path=Keyboard/KEYBOARDS"
    }
}
