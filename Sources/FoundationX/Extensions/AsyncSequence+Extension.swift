//
//  AsyncSequence+Extension.swift
//  FoundationX 
// 
//  Created by Guanghui Liang on 2026/5/25.
//  Copyright © 2026 Guanghui Liang. All rights reserved.
//

import Foundation

public extension AsyncSequence {
    /// Collects every element emitted by the async sequence into an array, preserving iteration order.
    func collect() async throws -> [Element] {
        try await reduce(into: [Element]()) { $0.append($1) }
    }
}
