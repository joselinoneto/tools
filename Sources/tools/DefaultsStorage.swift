//
//  File.swift
//  
//
//  Created by José Neto on 18/09/2022.
//

import Foundation

public enum DefaultKey: String {
    case numberColumns = "number-columns-key"
}

public class DafaultsStorage {
    private static let userDefaults = UserDefaults.standard
    
    public static func getIntValue(key: DefaultKey) -> Int {
        userDefaults.integer(forKey: key.rawValue).defaultValue
    }
    
    public static func getStringValue(key: DefaultKey) -> String? {
        userDefaults.string(forKey: key.rawValue)
    }
    
    public static func setIntValue(_ value: Int, key: DefaultKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    public static func setStringValue(_ value: String, key: DefaultKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
}

private extension Int {
    var defaultValue: Int {
        return self <= 0 ? 1 : self
    }
}
