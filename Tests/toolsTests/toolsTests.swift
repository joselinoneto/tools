import XCTest
@testable import tools

final class toolsTests: XCTestCase {
    func testKeyChainStorage() throws {
        let value: String = "value"
        let key: String = "key"
        
        XCTAssertNoThrow(try KeychainStorage.shared.set(newValue: value, forKey: key))
        XCTAssertNoThrow(try KeychainStorage.shared.getValueForKey(key))
    }
    
    func testClearKeyChainStorage() throws {
        XCTAssertNoThrow(try KeychainStorage.shared.clearStorage())
    }
    
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
        DafaultsStorage.clearUserDefatuls()
        let testIntValue2: Int = DafaultsStorage.getIntValue(key: .numberColumns)
        XCTAssertEqual(2, testIntValue2)
        
        let intValue: Int = Int.random(in: 1...100)
        DafaultsStorage.setIntValue(intValue, key: .numberColumns)
        let testIntValue: Int = DafaultsStorage.getIntValue(key: .numberColumns)
        
        XCTAssertEqual(intValue, testIntValue)
    }
    
    func testConfigStorage()  {
        let config = ConfigLoader.shared.appConfig
        XCTAssertNotNil(config?.apiUrl)
    }
}
