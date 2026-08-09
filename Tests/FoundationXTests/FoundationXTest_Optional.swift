//
//  FoundationXTest_Optional.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import XCTest
@testable import FoundationX

final class FoundationXOptionalTests: XCTestCase {
    func testOptionalCollectionIsNilOrEmpty() {
        let string: String? = "123"
        let integers: [Int]? = []
        let missingDictionary: [String: Int]? = nil

        XCTAssertFalse(string.isNilOrEmpty)
        XCTAssertTrue(integers.isNilOrEmpty)
        XCTAssertTrue(missingDictionary.isNilOrEmpty)
    }
}
