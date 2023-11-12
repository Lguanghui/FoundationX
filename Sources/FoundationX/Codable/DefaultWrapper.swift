//
//  DefaultWrapper.swift
//  FoundationX
//
//  Created by 梁光辉 on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

/// 类通过实现该协议提供默认值
public protocol CodableDefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

/// 针对 Bool 的协议
public protocol BoolDefaultValue: CodableDefaultValue where Value == Bool { }

//MARK: - CodableDefault 实现

/// 解决 Codable 的某个 key 解码失败时（比如类型不匹配），导致全部解码失败的问题
///
/// `@CodableDefault<TYPE> var property`，解码失败时会将 property 设置为 TYPE 定义的默认值
@propertyWrapper
public struct CodableDefault<T: CodableDefaultValue>: Codable {
    
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        // CodableDefault 是一个单值容器（对应某个属性）
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

// MARK: - KeyedDecodingContainer 扩展

public extension KeyedDecodingContainer {
    
    /// CodableDefault 默认 decode 实现
    ///
    /// 解决 Codable 的某个 key 不存在时解析失败的问题，如果 key 不存在，就使用 T 类型关联的默认值
    func decode<T>(_ type: CodableDefault<T>.Type, forKey key: Key) throws -> CodableDefault<T> where T: CodableDefaultValue {
        if let val = try decodeIfPresent(type, forKey: key) {
            return val
        }
        return CodableDefault(wrappedValue: T.defaultValue)
    }
    
    /// 针对 Bool 的 decode 实现
    ///
    /// 兼容了整型和字符串类型转换为 Bool
    /// 1. 整数转 Bool, 0 对应 false, 其它为 true
    /// 2. 字符串转 Bool, "true"/"false" 对应 true/false（大小写敏感）, 其它 bool 为 nil, 会走到 T.defaultValue
    func decode<T>(_ type: CodableDefault<T>.Type, forKey key: Key) throws -> CodableDefault<T> where T: BoolDefaultValue {
        do {
            let val = try decode(Bool.self, forKey: key)
            return CodableDefault(wrappedValue: val)
        } catch let err {
            // 如果是因为类型不匹配 decode 失败，可以再尝试转换为 Int 和 String
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

// MARK: - 常用的 wrapper

/// 修饰 Bool 类型的变量，默认值为 true
public typealias DefaultTrue = CodableDefault<Bool.True>

/// 修饰 Bool 类型的变量，默认值为 false
public typealias DefaultFalse = CodableDefault<Bool.False>

/// 修饰 Int 类型的变量，默认值为 0
public typealias DefaultIntZero = CodableDefault<Int.Zero>

/// 修饰 Float 类型的变量，默认值为 0
public typealias DefaultFloatZero = CodableDefault<Float.Zero>

/// 修饰 Double 类型的变量，默认值为 0
public typealias DefaultDoubleZero = CodableDefault<Double.Zero>

/// 修饰 String 类型的变量，默认值为 ""
public typealias DefaultEmptyString = CodableDefault<String.Empty>

/// 修饰 Array 类型的变量，默认值为 []
public typealias DefaultEmptyArray<T> = CodableDefault<CodableEmptyArray<T>> where T: Codable

/// 修饰 Dictionary 类型的变量，默认值为 [:]
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
