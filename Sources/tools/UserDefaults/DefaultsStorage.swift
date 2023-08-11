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

public class DefaultsStorage: ObservableObject {
    @UserDefault(key: .favoritesNumberColumns)
    private var favoritesNumberColumns: Double?

    @UserDefault(key: .archiveNumberColumns)
    private var archiveNumberColumns: Double?

    @UserDefault(key: .isImageModeEnabled)
    private var imageModeEnabled: Bool?

    @UserDefault(key: .searchKey)
    private var searchKey: String?

    @UserDefault(key: .detailsKey)
    private var detailsKey: String?

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

    @Published public var searchValue: String {
        didSet {
            searchKey = searchValue
        }
    }

    @Published public var detailsValue: String {
        didSet {
            detailsKey = detailsValue
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
