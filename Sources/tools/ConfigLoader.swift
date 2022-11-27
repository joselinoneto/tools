//
//  ConfigLoader.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 19/02/2022.
//

import Foundation

public class ConfigLoader {
    public static let shared: ConfigLoader = ConfigLoader()
    public let appConfig: AppConfiguration?

    private init() {
        appConfig = ConfigLoader.parseFile()
    }

    private static func parseFile() -> AppConfiguration? {
        guard let filePath = Bundle.module.url(forResource: "Config", withExtension: "plist") else { return nil }
        guard let fileData: Data = try? String(contentsOf: filePath).data(using: .utf8) else { return nil }
        let config = try? PropertyListDecoder().decode(AppConfiguration.self, from: fileData)
        return config
    }
}

public struct AppConfiguration: Decodable {
    public let config: String
    public let apiUrl: String
    public let testFlags: TestFlags?
    public let token: String
    
    enum CodingKeys: String, CodingKey {
        case config
        case apiUrl = "api-url"
        case testFlags
        case token
    }
}

public struct TestFlags: Decodable {
    public let resetData: Bool
    public let noSplash: Bool
    public let applyTestData: Bool
}
