//
//  Macros.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2025/8/23.
//  Copyright © 2025 Guanghui Liang. All rights reserved.
//

/// A macro that creates a string value by joining the given parameters.
/// For example,
///
///     #stringify(x + y, 1 + 2, 3 + 4)
///
/// produces a tuple `"x + y 1 + 2 3 + 4"`.
@freestanding(expression)
public macro stringify(_ value: Any...) -> String = #externalMacro(module: "FoundationXMacro", type: "StringifyMacro")
