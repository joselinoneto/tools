//
//  ConfigLoader.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 19/02/2022.
//

import Foundation

public class ConfigLoader {
    public static let shared: ConfigLoader = ConfigLoader()
    public let appConfig: AppConfiguration

    private init() {
        appConfig = ConfigLoader.parseFile()
    }

    private static func parseFile() -> AppConfiguration {
        let fileName: String = "Config.plist"
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let fileData = FileManager.default.contents(atPath: filePath)
        else {
            fatalError("Config file '\(fileName)' not loadable!")
        }

        do {
            let config = try PropertyListDecoder().decode(AppConfiguration.self, from: fileData)
            return config
        } catch {
            fatalError("Configuration not decodable from '\(fileName)': \(error)")
        }
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
