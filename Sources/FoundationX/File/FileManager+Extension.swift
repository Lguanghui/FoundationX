//
//  File.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/2/17.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

#if os(iOS)
public extension FileManager {
    /// Returns the disk space used by the current iOS application in bytes.
    func applicationSize() -> UInt64 {
        var totalSizeInBytes: UInt64 = 0
        if let documentURL = urls(for: .documentDirectory, in: .userDomainMask).first {
            totalSizeInBytes += documentURL.fileSize()
        }
        if let cachesURL = urls(for: .cachesDirectory, in: .userDomainMask).first {
            totalSizeInBytes += cachesURL.fileSize()
        }

        totalSizeInBytes += Bundle.main.bundleURL.fileSize()

        return totalSizeInBytes
    }
}
#endif
