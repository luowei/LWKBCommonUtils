//
// Created by luowei on 2019/1/31.
// Copyright (c) 2019 wodedata. All rights reserved.
//

import Foundation

public class LWDataPipeManager {

    // MARK: - Private Constants

    private static let appGroupSuiteName = "group.com.wodedata.LWInputMethod"

    // MARK: - Public Methods

    /// Get value by key, checking App Group first, then UserDefaults
    public static func getValue(forKey key: String) -> Any? {
        if let value = getAppGroupValue(forKey: key) {
            return value
        }

        let value = getUserDefaultValue(forKey: key)
        if let value = value {
            setAppGroupValue(value, forKey: key)
        }
        return value
    }

    /// Set value for both UserDefaults and App Group
    public static func setValue(_ value: Any?, forKey key: String) {
        setUserDefaultValue(value, forKey: key)
        setAppGroupValue(value, forKey: key)
    }

    // MARK: - UserDefaults Methods

    /// Get value from UserDefaults
    public static func getUserDefaultValue(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    /// Set value in UserDefaults
    public static func setUserDefaultValue(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    // MARK: - App Group Methods

    /// Get value from App Group
    public static func getAppGroupValue(forKey key: String) -> Any? {
        guard let userDefaults = UserDefaults(suiteName: appGroupSuiteName) else {
            return nil
        }
        return userDefaults.object(forKey: key)
    }

    /// Set value in App Group
    public static func setAppGroupValue(_ value: Any?, forKey key: String) {
        guard let userDefaults = UserDefaults(suiteName: appGroupSuiteName) else {
            return
        }
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    // MARK: - Legacy Method Names (for compatibility)

    /// Get value from App Group (legacy method name)
    @available(*, deprecated, renamed: "getAppGroupValue(forKey:)")
    public static func getMyInputMethodAPPGroupValue(forKey key: String) -> Any? {
        return getAppGroupValue(forKey: key)
    }

    /// Set value in App Group (legacy method name)
    @available(*, deprecated, renamed: "setAppGroupValue(_:forKey:)")
    public static func setMyInputMethodAPPGroupValue(_ value: Any?, forKey key: String) {
        setAppGroupValue(value, forKey: key)
    }
}

// MARK: - Type-Safe Extensions

public extension LWDataPipeManager {

    /// Get String value
    static func getString(forKey key: String) -> String? {
        return getValue(forKey: key) as? String
    }

    /// Get Int value
    static func getInt(forKey key: String) -> Int? {
        return getValue(forKey: key) as? Int
    }

    /// Get Bool value
    static func getBool(forKey key: String) -> Bool? {
        return getValue(forKey: key) as? Bool
    }

    /// Get Double value
    static func getDouble(forKey key: String) -> Double? {
        return getValue(forKey: key) as? Double
    }

    /// Get Array value
    static func getArray(forKey key: String) -> [Any]? {
        return getValue(forKey: key) as? [Any]
    }

    /// Get Dictionary value
    static func getDictionary(forKey key: String) -> [String: Any]? {
        return getValue(forKey: key) as? [String: Any]
    }

    /// Get Data value
    static func getData(forKey key: String) -> Data? {
        return getValue(forKey: key) as? Data
    }
}

// MARK: - Codable Support

public extension LWDataPipeManager {

    /// Save Codable object
    static func setCodable<T: Codable>(_ value: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        setValue(data, forKey: key)
    }

    /// Get Codable object
    static func getCodable<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = getData(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
