//
//  FoundationXMacroClient.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2025/8/23.
//  Copyright © 2025 Guanghui Liang. All rights reserved.
//

import FoundationX

@main
struct FoundationXMacroClient {
    static func main() {
        
    }
}

func testStringifyMacro() {
    let str = #stringify(1 + 2)
    print(str)
}
