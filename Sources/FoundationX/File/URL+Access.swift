//
//  URL+Access.swift
//  FoundationX
// 
//  Created by 梁光辉 on 2024/5/13.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

#if os(macOS)

public enum SecurityScopedResourceError: Error {
    case accessDenied(URL)
}

public extension URL {

    /// Save the URL bookmark data with a specific key to access the file/folder.
    /// - Parameter key: UserDefaults key.
    func saveBookmarkData(for key: String) {
        do {
            let bookmarkData = try bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            UserDefaults.standard.set(bookmarkData, forKey: key)
        } catch {
            XLogger.log("Failed to save bookmark data for \(self)", error)
        }
    }

    /// Performs an operation while access to a security-scoped bookmark is active.
    static func withSecurityScopedAccess<T>(forKey key: String, perform operation: (URL) throws -> T) throws -> T? {
        guard let bookmark = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        var isStale = false
        let url = try URL(resolvingBookmarkData: bookmark, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)

        if isStale {
            let refreshedBookmark = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            UserDefaults.standard.set(refreshedBookmark, forKey: key)
        }

        guard url.startAccessingSecurityScopedResource() else {
            throw SecurityScopedResourceError.accessDenied(url)
        }
        defer { url.stopAccessingSecurityScopedResource() }

        return try operation(url)
    }

    /// Checks whether bookmark access can be started.
    @available(*, deprecated, message: "Use withSecurityScopedAccess(forKey:perform:) to keep access active for the operation.")
    static func restoreFileAccess(key: String) -> Bool {
        do {
            return try withSecurityScopedAccess(forKey: key) { _ in true } ?? false
        } catch {
            XLogger.log("Error resolving bookmark:", error)
            return false
        }
    }
}

#endif
