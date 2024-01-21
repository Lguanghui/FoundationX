//
//  Value.swift
//  FoundationX
// 
//  Created by Guanghui Liang on 2024/1/21.
//  Copyright © 2024 Guanghui Liang. All rights reserved.
//

import Foundation

public protocol DefaultValue {
    associatedtype ValueType: Equatable
    static var defaultValue: ValueType { get }
}

public enum Value<T>: Equatable where T: Equatable {
    case none
    case some(value: T)
}

extension Value where T: DefaultValue, T.ValueType == T {
    public var realValue: T {
        if case let Self.some(value) = self {
            return value
        } else {
            return T.defaultValue
        }
    }
}

extension Bool: DefaultValue {
    public static var defaultValue: Bool {
        return false
    }
}

extension Int: DefaultValue {
    public static var defaultValue: Int {
        return 0
    }
}

extension Float: DefaultValue {
    public static var defaultValue: Self {
        return 0.0
    }
}

extension Double: DefaultValue {
    public static var defaultValue: Self {
        return 0.0
    }
}

extension String: DefaultValue {
    public static var defaultValue: Self {
        return ""
    }
}
