//
//  FoundationXMacroPlugin.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2025/8/23.
//  Copyright © 2025 Guanghui Liang. All rights reserved.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct FoundationXMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}
