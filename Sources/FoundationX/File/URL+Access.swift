//
//  URL+Access.swift
//  FoundationX
// 
//  Created by 梁光辉 on 2024/5/13.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

@available(macOS 10.7, *)
public extension URL {
    
    func saveBookmarkData(for key: String) {
        do {
            let bookmarkData = try self.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            UserDefaults.standard.setValue(bookmarkData, forKey: key)
        } catch {
            XLogger.printMessage("Failed to save bookmark data for \(self)", error)
        }
    }

    static func restoreFileAccess(key: String) -> Bool {
        do {
            if let bookmark = UserDefaults.standard.object(forKey: key) as? Data {
                var bookmarkDataIsStale = false
                let url = try URL(resolvingBookmarkData: bookmark, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &bookmarkDataIsStale)
                guard url.startAccessingSecurityScopedResource() else {
                    return false
                }
                return true
            }
            return false
        } catch {
            XLogger.printMessage("Error resolving bookmark:", error)
            return false
        }
    }
}

