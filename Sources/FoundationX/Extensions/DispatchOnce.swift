//
//  DispatchOnce.swift
//  FoundationX
// 
//  Created by Guanghui Liang on 2024/2/25.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    private static var _onceTracker = [String]()

    /// Swift's DispatchOnce implementation. It's Thread safe.
    /// - Parameters:
    ///   - token: A unique string.
    ///   - block: Block to execute once
    class func once(token: String, block: () -> Void ) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
