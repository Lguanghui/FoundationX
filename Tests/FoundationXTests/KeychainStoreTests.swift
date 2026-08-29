//
//  KeychainStoreTests.swift
//  FoundationXTests
//
//  Created by Guanghui Liang on 2026/8/29.
//  Copyright © 2026 Guanghui Liang. All rights reserved.
//

import Foundation
import XCTest
@testable import FoundationX

final class KeychainStoreTests: XCTestCase {
    private var store: KeychainStore!
    private var key: String!

    override func setUp() {
        super.setUp()
        store = KeychainStore(service: "com.liangguanghui.FoundationXTests.\(UUID().uuidString)")
        key = UUID().uuidString
    }

    override func tearDown() {
        try? store.removeValue(forKey: key)
        store = nil
        key = nil
        super.tearDown()
    }

    func testDataLifecycle() throws {
        XCTAssertNil(try store.data(forKey: key))

        try store.set(Data("first".utf8), forKey: key)
        XCTAssertEqual(try store.data(forKey: key), Data("first".utf8))

        try store.set(Data("second".utf8), forKey: key)
        XCTAssertEqual(try store.data(forKey: key), Data("second".utf8))

        try store.removeValue(forKey: key)
        XCTAssertNil(try store.data(forKey: key))
        XCTAssertNoThrow(try store.removeValue(forKey: key))
    }

    func testStringLifecycle() throws {
        try store.set("secret", forKey: key)
        XCTAssertEqual(try store.string(forKey: key), "secret")
    }

    func testInvalidUTF8Throws() throws {
        try store.set(Data([0xFF]), forKey: key)
        XCTAssertThrowsError(try store.string(forKey: key)) { error in
            XCTAssertEqual(error as? KeychainStoreError, .invalidData)
        }
    }
}
