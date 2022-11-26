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

    public func getValueForKey(_ key: String) throws -> String? {
        do {
            return try keyChainWrapper.getString(key)
        } catch {
            throw error
        }
    }

    public func set(newValue: String, forKey: String) throws {
        do {
            try keyChainWrapper.set(newValue, key: forKey)
        } catch {
            throw error
        }
    }

    public func clearStorage() throws {
        do {
            try keyChainWrapper.removeAll()
        } catch {
            throw error
        }
    }
}
