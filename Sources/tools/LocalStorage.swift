//
//  LocalStorage.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation

public class FileStorage {
    let fileExtension: String = ".jpg"
    public static let shared: FileStorage = FileStorage()
    
    public var folderUrl: URL? {
        //FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.zeneto.astronomia-app")
        try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    //private var assetsPath: URL? {
    //    FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    //}
    
    public func getLocalFile(fileName: String) -> URL? {
        let filePath = folderUrl?.appendingPathComponent("\(fileName)\(fileExtension)")
        guard let filePathString: String = filePath?.path else { return nil }
        return FileManager.default.fileExists(atPath: filePathString) ? filePath : nil
    }
    
    public func saveRemoteFile(imageUrl: URL?, fileName: String?) async throws {
        guard let folderUrl = folderUrl else { return }
        guard let imageUrl = imageUrl else { return }
        guard let fileName = fileName else { return }
        let fileURL = folderUrl.appendingPathComponent("\(fileName)\(fileExtension)")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return 
        }
        let data = try await URLSession.shared.download(from: imageUrl)
        try FileManager.default.moveItem(atPath: data.0.path, toPath: fileURL.path)
    }
}
