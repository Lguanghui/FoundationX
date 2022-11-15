//
//  Optional+Empty.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2022/11/11.
//  Copyright © 2022 Guanghui Liang. All rights reserved.
//

import Foundation

// MARK: - Optional String + Empty
extension Swift.Optional where Wrapped == String {
    
    /// Get whether  this `Optional String` instance  is nil or an empty String.
    ///
    /// If this `Optional String` instance is  **nil**, `isNilOrEmpty`  will return `true`.
    ///
    ///     let testStr: String? = nil
    ///     print(testStr.isNilOrEmpty)
    ///     // Prints true
    ///
    /// If this `Optional String` instance is an **empty String**, then `isNilOrEmpty`  will also return `true`.
    ///
    ///     let testStr: String? = ""
    ///     print(testStr.isNilOrEmpty)
    ///     // Prints true
    ///
    /// If this `Optional String` instance is a **non-empty String**, then `isNilOrEmpty`  will return `false`.
    ///
    ///     let testStr: String? = "test"
    ///     print(testStr.isNilOrEmpty)
    ///     // Prints false
    ///     
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

// MARK: - Optional Array + Empty
extension Swift.Optional where Wrapped == Array<Any> {
    
    /// Get whether  this `Optional Array<Any>`  is nil or an empty String.
    ///
    /// If this `Optional Array<Any>` is  **nil**,  call of `isNilOrEmpty`  will return `true`.
    ///
    ///     let array: [Any]? = nil
    ///     print(array.isNilOrEmpty)
    ///     // Prints true
    ///
    /// If this `Optional Array<Any>` is an **empty** Array, then `isNilOrEmpty`  will also return `true`.
    ///
    ///     let array: [Any]? = []
    ///     print(array.isNilOrEmpty)
    ///     // Prints true
    ///
    /// If this `Optional Array<Any>` is a **non-empty** Array, then `isNilOrEmpty`  will return `false`.
    ///
    ///     let array: [Any]? = [1, 2, 3]
    ///     print(testStr.isNilOrEmpty)
    ///     // Prints false
    ///
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
