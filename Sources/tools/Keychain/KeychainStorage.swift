//
//  File.swift
//  
//
//  Created by José Neto on 30/05/2023.
//


import Foundation
import KeychainAccess

extension KeychainKey {
    public static let accessToken: KeychainKey = "api-access-token"
    public static let deviceId: KeychainKey = "device-id"
}

public struct KeychainStorage {
    private var keychainWrapper: Keychain
    public static var shared: KeychainStorage = KeychainStorage()

    @UserKeyChain(key: .accessToken)
    public var accessToken: String?

    @UserKeyChain(key: .deviceId)
    public var userDeviceId: String?

    private init() {
        keychainWrapper = Keychain()
    }

    public func clearStorage() throws {
        try keychainWrapper.removeAll()
    }
}
