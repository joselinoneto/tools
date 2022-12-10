//
//  ConfigLoader.swift
//  Astronomy Picute Today
//
//  Created by José Lino Neto on 19/02/2022.
//

import Foundation

public class ConfigLoader {
    public let appConfig: AppConfiguration
    public static let shared: ConfigLoader = ConfigLoader(fileName: "Config.plist")

    public init(fileName: String) {
        appConfig = ConfigLoader.parseFile(fileName: fileName)
    }

    private static func parseFile(fileName: String) -> AppConfiguration {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
            let fileData = FileManager.default.contents(atPath: filePath)
        else {
            let localPath = FileStorage.shared.folderUrl?.appendingPathComponent(fileName)
            let localFileData = try? String.init(contentsOf: localPath!, encoding: .utf8)
            let content = localFileData?.data(using: .utf8)
            return parseData(data: content)
        }
        
        return parseData(data: fileData)
    }
    
    private static func parseData(data: Data?) -> AppConfiguration {
        guard let data = data else { return AppConfiguration.empty }
        do {
            return try PropertyListDecoder().decode(AppConfiguration.self, from: data)
        } catch {
            return AppConfiguration.empty
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
    
    init(config: String, apiUrl: String, testFlags: TestFlags?, token: String) {
        self.config = config
        self.apiUrl = apiUrl
        self.testFlags = testFlags
        self.token = token
    }
    
    public static var empty: AppConfiguration = {
        AppConfiguration(config: "", apiUrl: "", testFlags: nil, token: "")
    }()
}

public struct TestFlags: Decodable {
    public let resetData: Bool
    public let noSplash: Bool
    public let applyTestData: Bool
}
