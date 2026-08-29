//
//  KeychainStore.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2026/8/29.
//  Copyright © 2026 Guanghui Liang. All rights reserved.
//

import Foundation
import Security

/// A lightweight generic-password store backed by the system Keychain.
///
/// `KeychainStore` contains no application-specific keys or migration policy. Configure a
/// separate service for each credential namespace and keep those policies in the consumer.
public struct KeychainStore: Sendable {
    public enum Accessibility: Sendable {
        case whenUnlocked
        case afterFirstUnlock
        case whenUnlockedThisDeviceOnly
        case afterFirstUnlockThisDeviceOnly

        fileprivate var value: CFString {
            switch self {
            case .whenUnlocked:
                kSecAttrAccessibleWhenUnlocked
            case .afterFirstUnlock:
                kSecAttrAccessibleAfterFirstUnlock
            case .whenUnlockedThisDeviceOnly:
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            case .afterFirstUnlockThisDeviceOnly:
                kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            }
        }
    }

    public let service: String
    public let accessGroup: String?
    public let synchronizable: Bool
    public let accessibility: Accessibility

    public init(
        service: String,
        accessGroup: String? = nil,
        synchronizable: Bool = false,
        accessibility: Accessibility = .afterFirstUnlockThisDeviceOnly
    ) {
        self.service = service
        self.accessGroup = accessGroup
        self.synchronizable = synchronizable
        self.accessibility = accessibility
    }

    public func data(forKey key: String) throws(KeychainStoreError) -> Data? {
        var query = itemQuery(forKey: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecItemNotFound {
            return nil
        }
        guard status == errSecSuccess else {
            throw .unhandledStatus(status)
        }
        guard let data = result as? Data else {
            throw .invalidData
        }
        return data
    }

    public func string(forKey key: String) throws(KeychainStoreError) -> String? {
        guard let data = try data(forKey: key) else {
            return nil
        }
        guard let value = String(data: data, encoding: .utf8) else {
            throw .invalidData
        }
        return value
    }

    public func set(_ data: Data, forKey key: String) throws(KeychainStoreError) {
        let query = itemQuery(forKey: key)
        let attributes = valueAttributes(data: data)
        let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        if updateStatus == errSecSuccess {
            return
        }
        guard updateStatus == errSecItemNotFound else {
            throw .unhandledStatus(updateStatus)
        }

        var item = query
        attributes.forEach { item[$0.key] = $0.value }
        let addStatus = SecItemAdd(item as CFDictionary, nil)
        if addStatus == errSecSuccess {
            return
        }

        // Another writer may insert the same item between the update and add calls.
        if addStatus == errSecDuplicateItem {
            let retryStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            guard retryStatus == errSecSuccess else {
                throw .unhandledStatus(retryStatus)
            }
            return
        }
        throw .unhandledStatus(addStatus)
    }

    public func set(_ string: String, forKey key: String) throws(KeychainStoreError) {
        try set(Data(string.utf8), forKey: key)
    }

    public func removeValue(forKey key: String) throws(KeychainStoreError) {
        let status = SecItemDelete(itemQuery(forKey: key) as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw .unhandledStatus(status)
        }
    }

    private func itemQuery(forKey key: String) -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecAttrSynchronizable as String: synchronizable
        ]
        if let accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        return query
    }

    private func valueAttributes(data: Data) -> [String: Any] {
        [
            kSecValueData as String: data,
            kSecAttrAccessible as String: accessibility.value
        ]
    }
}

public enum KeychainStoreError: Error, Equatable, LocalizedError, Sendable {
    case invalidData
    case unhandledStatus(OSStatus)

    public var errorDescription: String? {
        switch self {
        case .invalidData:
            "The Keychain item contains invalid data."
        case let .unhandledStatus(status):
            SecCopyErrorMessageString(status, nil) as String? ?? "Keychain operation failed with status \(status)."
        }
    }
}
