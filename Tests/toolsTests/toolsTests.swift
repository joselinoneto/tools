import XCTest
@testable import tools

final class toolsTests: XCTestCase {
    func testKeyChainStorage() throws {
        let value: String = "value"
        let key: String = "key"
        
        XCTAssertThrowsError(try KeychainStorage.shared.set(newValue: value, forKey: key))
        XCTAssertThrowsError(try KeychainStorage.shared.getValueForKey(key))
        
        // TODO: set entitlement for keychain in spm
        //let valueRestore: String? = try KeychainStorage.shared.getValueForKey(key)
        //XCTAssertEqual(value, valueRestore)
    }
    
    func testClearKeyChainStorage() throws {
        XCTAssertThrowsError(try KeychainStorage.shared.clearStorage())
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
}
