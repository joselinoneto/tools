//
//  File.swift
//  
//
//  Created by José Neto on 18/09/2022.
//

import Foundation

extension Key {
    static let numberColumns: Key = "number-columns-key"
    static let isImageModeEnabled: Key = "is-image-mode-enabled"
}

public struct DafaultsStorage {
    @UserDefault(key: .numberColumns)
    var numberColumns: Int?

    @UserDefault(key: .isImageModeEnabled)
    var isImageModeEnabled: Bool?
}
