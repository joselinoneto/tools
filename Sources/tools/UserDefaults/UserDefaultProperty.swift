//
//  File.swift
//  
//
//  Created by José Neto on 26/02/2023.
//

import Foundation

@propertyWrapper
public struct UserDefault<T: PropertyListValue> {
    public let key: Key

    public var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}
