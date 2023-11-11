//
//  ConfigLoader.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 19/02/2022.
//

import Foundation

public class ConfigLoader {
    public let appConfig: AppConfiguration
    public static let shared: ConfigLoader = ConfigLoader()

    private init() {
        guard let bundle = Bundle.main.infoDictionary else {
            appConfig = AppConfiguration.empty
            return
        }

        guard let url = bundle["API_URL"] as? String else {
            appConfig = AppConfiguration.empty
            return
        }

        appConfig = AppConfiguration(apiUrl: url)
    }
}

public struct AppConfiguration: Decodable {
    public let apiUrl: String
    
    enum CodingKeys: String, CodingKey {
        case apiUrl = "api-url"
    }
    
    init(apiUrl: String) {
        self.apiUrl = apiUrl
    }
    
    public static var empty: AppConfiguration = {
        AppConfiguration(apiUrl: "")
    }()
}
