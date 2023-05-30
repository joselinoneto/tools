import XCTest
@testable import tools

final class toolsTests: XCTestCase {
    let xml = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>token</key>
<string>TOKEN_KEY_STORAGE</string>
<key>config</key>
<string>Dev</string>
<key>api-url</key>
<string>https://zeneto.app/</string>
</dict>
</plist>
"""
    
    let xmlError = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>token</key>
<string>TOKEN_KEY_STORAGE</string>
<key>config</key>
<string>Dev</string>
<key>api-url</key
<string>https://zeneto.app/</string>
</dict>
</plist>
"""
    func testLocalStorage() async throws {
        let url: String = "https://zeneto.app/template/badgeappstore.png"
        let imageURL: URL? = URL(string: url)
        let fileName: String = UUID().uuidString
        try await FileStorage.shared.saveRemoteFile(imageUrl: imageURL, fileName: fileName)
        let localUrl: URL? = FileStorage.shared.getLocalFile(fileName: fileName)
        
        // try save again and cover more code
        try await FileStorage.shared.saveRemoteFile(imageUrl: imageURL, fileName: fileName)
        
        XCTAssertNotNil(localUrl)
    }
    
    func testFolderLocalStorage()  {
        let localFolder: URL? = FileStorage.shared.folderUrl
        XCTAssertNotNil(localFolder)
    }
    
    func testDefaultsStorage()  {
        let testValue: Int = 100

        var storage = DafaultsStorage()
        storage.numberColumns = testValue
        
        let newStorage = DafaultsStorage()
        let value: Int = newStorage.numberColumns ?? 0

        XCTAssertEqual(value, testValue)
    }
    
    func testConfigLoader() {
        
        let data: Data? = xml.data(using: .utf8)
        let folderUrl = FileStorage.shared.folderUrl?.appendingPathComponent("Config.plist")
        try? data?.write(to: folderUrl!)
        
        let config = ConfigLoader.shared
        let url = config.appConfig.apiUrl
        XCTAssertNotEqual("", url)
    }
    
    func testConfigLoaderError() {
        let configError = ConfigLoader(fileName: "ConfigError.plist")
        let urlError = configError.appConfig.apiUrl
        XCTAssertEqual("", urlError)
        
        let data: Data? = xmlError.data(using: .utf8)
        let folderUrl = FileStorage.shared.folderUrl?.appendingPathComponent("ConfigParseError.plist")
        try? data?.write(to: folderUrl!)
        
        let config = ConfigLoader(fileName: "ConfigParseError.plist")
        let url = config.appConfig.apiUrl
        XCTAssertEqual("", url)
    }
}
