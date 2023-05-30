//
//  KeychainKey.swift
//  
//
//  Created by José Neto on 30/05/2023.
//

import Foundation

public struct KeychainKey: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension KeychainKey: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}
