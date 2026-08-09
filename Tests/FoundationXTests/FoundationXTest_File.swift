//
//  FoundationXTest_File.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#if os(iOS)
import XCTest
@testable import FoundationX

final class FoundationXFileTests: XCTestCase {
    func testApplicationSizeIsAvailableOnIOS() {
        _ = FileManager.default.applicationSize()
    }
}
#endif
