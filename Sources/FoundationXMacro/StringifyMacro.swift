//
//  StringifyMacro.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2025/8/23.
//  Copyright © 2025 Guanghui Liang. All rights reserved.
//

import SwiftSyntaxMacros
import SwiftSyntax
import SwiftSyntaxBuilder

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "\(argument)"
    }
}
