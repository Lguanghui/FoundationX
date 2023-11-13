//
//  URL+FileSize.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/2/17.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public extension URL {
    /// get file size with current URL. Return folder size by `directorySize()`, if it's a folder URL.
    /// - Returns: file size in `Bytes`
    func fileSize() -> UInt64 {
        var isDirectory = ObjCBool(true)
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if isDirectory.boolValue {
            return directorySize()
        } else {
            do {
                let rawSize = try FileManager.default.attributesOfItem(atPath: path)[.size] as? NSNumber
                return rawSize?.uint64Value ?? 0
            } catch {
                return 0
            }
        }
    }
    
    /// get folder size with current.
    /// - Returns: folder size in `Bytes`
    func directorySize() -> UInt64 {
        var totalSizeInBytes: UInt64 = 0
        do {
            let files: [URL] = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: [.localizedNameKey, .creationDateKey, .localizedTypeDescriptionKey], options: .skipsHiddenFiles)
            for file in files {
                totalSizeInBytes += file.fileSize()
            }
            return totalSizeInBytes
        } catch {
            return 0
        }
    }
}
