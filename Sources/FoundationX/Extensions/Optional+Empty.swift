//
//  Optional+Empty.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2022/11/11.
//  Copyright © 2022 Guanghui Liang. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection {
    /// Returns `true` when the optional collection is `nil` or empty.
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped == Character {
    var stringValue: String {
        guard let self else {
            return ""
        }
        return String(self)
    }
}
