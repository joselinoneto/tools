//
//  KeychainStorage.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 03/03/2022.
//

import Foundation
import KeychainAccess

public class KeychainStorage {
    private var keyChainWrapper: Keychain
    private init() {
        keyChainWrapper = Keychain()
    }

    public static var shared: KeychainStorage = KeychainStorage()
    
    public func getValueForKey(_ key: String) -> String? {
        try? keyChainWrapper.getString(key)
    }
    
    public func set(newValue: String, forKey: String) {
        try? keyChainWrapper.set(newValue, key: forKey)
    }
    
    public func clearStorage() {
        try? keyChainWrapper.removeAll()
    }
}
