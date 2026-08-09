//
//  URL+FileSize.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/2/17.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public extension URL {
    /// Returns the file or directory size in bytes.
    func fileSize() -> UInt64 {
        var isDirectory = ObjCBool(false)
        guard FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) else {
            return 0
        }

        if isDirectory.boolValue {
            return directorySize()
        }

        let values = try? resourceValues(forKeys: [.fileSizeKey])
        return UInt64(values?.fileSize ?? 0)
    }

    /// Returns the allocated size of regular files in a directory hierarchy in bytes.
    func directorySize() -> UInt64 {
        let keys: Set<URLResourceKey> = [.isRegularFileKey, .isSymbolicLinkKey, .totalFileAllocatedSizeKey, .fileAllocatedSizeKey, .fileSizeKey]
        let options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsPackageDescendants]
        guard let enumerator = FileManager.default.enumerator(at: self, includingPropertiesForKeys: Array(keys), options: options) else {
            return 0
        }

        var totalSizeInBytes: UInt64 = 0
        for case let fileURL as URL in enumerator {
            guard let values = try? fileURL.resourceValues(forKeys: keys), values.isRegularFile == true, values.isSymbolicLink != true else {
                continue
            }

            let size = values.totalFileAllocatedSize ?? values.fileAllocatedSize ?? values.fileSize ?? 0
            totalSizeInBytes += UInt64(size)
        }
        return totalSizeInBytes
    }
}
