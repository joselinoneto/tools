//
//  File.swift
//  
//
//  Created by José Neto on 30/05/2023.
//

import Foundation
import KeychainAccess

@propertyWrapper
public struct UserKeyChain<T: PropertyListValue> {
    public let key: KeychainKey

    public var wrappedValue: T? {
        get { try? Keychain().getString(key.rawValue) as? T }
        set {
            guard let newValue = newValue as? String else { return }
            try? Keychain().set(newValue, key: key.rawValue)
        }
    }
}
