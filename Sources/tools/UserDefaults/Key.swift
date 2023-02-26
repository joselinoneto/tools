//
//  File.swift
//  
//
//  Created by José Neto on 26/02/2023.
//

import Foundation

public struct Key: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Key: ExpressibleByStringLiteral {
    public init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}
