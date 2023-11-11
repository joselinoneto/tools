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
    static let searchKey: Key = "search-key"
    static let detailsKey: Key = "details-key"
}

public class LocalDefaultStorage {
    @UserDefault(key: .favoritesNumberColumns)
    var favoritesNumberColumns: Double?

    @UserDefault(key: .archiveNumberColumns)
    var archiveNumberColumns: Double?

    @UserDefault(key: .isImageModeEnabled)
    var imageModeEnabled: Bool?

    @UserDefault(key: .searchKey)
    var searchKey: String?

    @UserDefault(key: .detailsKey)
    var detailsKey: String?
}

@Observable
public class DefaultsStorage {
    let localDefaultStorage = LocalDefaultStorage()
    public var favoritesNumColumns: Double {
        didSet {
            localDefaultStorage.favoritesNumberColumns = favoritesNumColumns
        }
    }

    public var archiveNumColumns: Double {
        didSet {
            localDefaultStorage.archiveNumberColumns = archiveNumColumns
        }
    }

    public var isImageModeEnabled: Bool {
        didSet {
            localDefaultStorage.imageModeEnabled = isImageModeEnabled
        }
    }

    public var searchValue: String {
        didSet {
            localDefaultStorage.searchKey = searchValue
        }
    }

    public var detailsValue: String {
        didSet {
            localDefaultStorage.detailsKey = detailsValue
        }
    }

    public static let shared: DefaultsStorage = DefaultsStorage()

    private init() {
        let num = UserDefaults.standard.double(forKey: Key.favoritesNumberColumns.rawValue)
        favoritesNumColumns = num > 0 ? num : 3

        let archiveNum = UserDefaults.standard.double(forKey: Key.archiveNumberColumns.rawValue)
        archiveNumColumns = archiveNum > 0 ? archiveNum : 2

        isImageModeEnabled = UserDefaults.standard.bool(forKey: Key.isImageModeEnabled.rawValue)

        let text = UserDefaults.standard.string(forKey: Key.searchKey.rawValue)
        searchValue = text ?? ""

        let key = UserDefaults.standard.string(forKey: Key.detailsKey.rawValue)
        detailsValue = key ?? ""
    }
}
