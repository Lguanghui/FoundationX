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

/// A macro that creates a string value by joining the given parameters.
/// For example,
///
///     #stringify(x + y, 1 + 2, 3 + 4)
///
/// produces a tuple `"x + y 1 + 2 3 + 4"`.
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard node.arguments.isEmpty == false else {
            fatalError("compiler bug: the macro does not have any valid arguments.")
        }
        let string: String = node.arguments.compactMap({ "\($0.expression)" }).joined(separator: " ")
        return "\(literal: string)"
    }
}
