//
//  File.swift
//  
//
//  Created by José Neto on 18/09/2022.
//

import Foundation

extension Key {
    static let favoritesNumberColumns: Key = "favorites-number-columns-key"
    static let archiveNumberColumns: Key = "archive-number-columns-key"
    static let isImageModeEnabled: Key = "is-image-mode-enabled"
}

public class DefaultsStorage: ObservableObject {
    @UserDefault(key: .favoritesNumberColumns)
    private var favoritesNumberColumns: Double?

    @UserDefault(key: .archiveNumberColumns)
    private var archiveNumberColumns: Double?

    @UserDefault(key: .isImageModeEnabled)
    private var imageModeEnabled: Bool?

    @Published public var favoritesNumColumns: Double {
        didSet {
            favoritesNumberColumns = favoritesNumColumns
        }
    }

    @Published public var archiveNumColumns: Double {
        didSet {
            archiveNumberColumns = archiveNumColumns
        }
    }

    @Published public var isImageModeEnabled: Bool {
        didSet {
            imageModeEnabled = isImageModeEnabled
        }
    }

    public static let shared: DefaultsStorage = DefaultsStorage()

    private init() {
        let num = UserDefaults.standard.double(forKey: Key.favoritesNumberColumns.rawValue)
        favoritesNumColumns = num > 0 ? num : 3

        let archiveNum = UserDefaults.standard.double(forKey: Key.archiveNumberColumns.rawValue)
        archiveNumColumns = archiveNum > 0 ? archiveNum : 2

        isImageModeEnabled = UserDefaults.standard.bool(forKey: Key.isImageModeEnabled.rawValue)
    }
}
