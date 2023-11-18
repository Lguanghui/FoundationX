//
//  DefaultWrapper.swift
//  FoundationX
//
//  Created by 梁光辉 on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

/// Implement this protocol to supply a default value for Codable when decode failed.
public protocol CodableDefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

/// Default value protocol for `Bool`.
public protocol BoolDefaultValue: CodableDefaultValue where Value == Bool { }

// MARK: - CodableDefault Implementation

/// This propertyWrapper will Supply a default value for a Codable variable while decode failed due to mismatched type or null value.
///
/// `@CodableDefault<TYPE> var property`, when decoding fails, property will be set to the default value defined by `TYPE`.
@propertyWrapper
public struct CodableDefault<T: CodableDefaultValue>: Codable {
    
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

// MARK: - KeyedDecodingContainer extensions

public extension KeyedDecodingContainer {
    
    /// Default decode implementation for `CodableDefault`.
    ///
    /// When decode failed due to null value, it will turn to return a default value.
    func decode<T>(_ type: CodableDefault<T>.Type, forKey key: Key) throws -> CodableDefault<T> where T: CodableDefaultValue {
        if let val = try decodeIfPresent(type, forKey: key) {
            return val
        }
        return CodableDefault(wrappedValue: T.defaultValue)
    }
    
    /// Decode implementation for Bool.
    ///
    /// Compatible with integer and string type conversion to `Bool`.
    /// - Convert integer to Bool, 0 corresponds to false, others are true.
    /// - String to Bool, "true" / "false" corresponds to true / false (case sensitive), while other bools are nil and will go to `T.defaultValue`.
    func decode<T>(_ type: CodableDefault<T>.Type, forKey key: Key) throws -> CodableDefault<T> where T: BoolDefaultValue {
        do {
            let val = try decode(Bool.self, forKey: key)
            return CodableDefault(wrappedValue: val)
        } catch let err {
            guard
                let decodingErr = err as? DecodingError,
                case .typeMismatch = decodingErr
            else {
                return CodableDefault(wrappedValue: T.defaultValue)
            }
            
            if let intVal = try? decodeIfPresent(Int.self, forKey: key) {
                let num = NSNumber(integerLiteral: intVal)
                return CodableDefault(wrappedValue: num.boolValue)
            }
            else if let strVal = try? decodeIfPresent(String.self, forKey: key),
                    let bool = Bool(strVal) {
                return CodableDefault(wrappedValue: bool)
            }
            else {
                return CodableDefault(wrappedValue: T.defaultValue)
            }
        }
    }
}

// MARK: - Common wrappers

/// Decorate variables of Bool type, with a default value of `true`.
public typealias DefaultTrue = CodableDefault<Bool.True>

/// Decorate variables of Bool type, with a default value of `false`.
public typealias DefaultFalse = CodableDefault<Bool.False>

/// Modifies a variable of type Int, with a default value of 0.
public typealias DefaultIntZero = CodableDefault<Int.Zero>

/// Decorate variables of type Float, with a default value of 0.
public typealias DefaultFloatZero = CodableDefault<Float.Zero>

/// Decorate variables of type Double, with a default value of 0.
public typealias DefaultDoubleZero = CodableDefault<Double.Zero>

/// Decorate a variable of type String, with a default value of `""`(empty string).
public typealias DefaultEmptyString = CodableDefault<String.Empty>

/// Decorate variables of type Array, with a default value of `[]`(empty array).
public typealias DefaultEmptyArray<T> = CodableDefault<CodableEmptyArray<T>> where T: Codable

/// Decorate a variable of type Dictionary, with a default value of `[:]`(empty dictionary).
public typealias DefaultEmptyDictionary<K, V> = CodableDefault<CodableEmptyDictionary<K, V>> where K: Codable & Hashable, V: Codable


public extension Bool {
    enum True: BoolDefaultValue {
        public static var defaultValue: Bool { return true }
    }
    enum False: BoolDefaultValue {
        public static var defaultValue: Bool { return false }
    }
}

public extension Int {
    enum Zero: CodableDefaultValue {
        public static var defaultValue: Int { return 0 }
    }
}

public extension Float {
    enum Zero: CodableDefaultValue {
        public static var defaultValue: Float { return 0 }
    }
}

public extension Double {
    enum Zero: CodableDefaultValue {
        public static var defaultValue: Double { return 0 }
    }
}

public extension String {
    enum Empty: CodableDefaultValue {
        public static var defaultValue: String { return "" }
    }
}

public struct CodableEmptyArray<T: Codable>: CodableDefaultValue {
    public static var defaultValue: [T] { return [] }
}

public struct CodableEmptyDictionary<Key: Codable & Hashable, Value: Codable>: CodableDefaultValue {
    public static var defaultValue: [Key: Value] { return [:] }
}
