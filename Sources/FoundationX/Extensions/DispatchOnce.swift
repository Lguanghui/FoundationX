//
//  DispatchOnce.swift
//  FoundationX
// 
//  Created by Guanghui Liang on 2024/2/25.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    @MainActor
    private static var onceTokens = Set<String>()

    /// Executes a block once for each token on the main actor.
    /// - Parameters:
    ///   - token: A unique string.
    ///   - block: Block to execute once
    @MainActor
    class func once(token: String, block: () -> Void) {
        guard onceTokens.insert(token).inserted else {
            return
        }
        block()
    }
}
