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
        testStringifyMacro()
    }
}

func testStringifyMacro() {
    let str = #stringify(1 + 2, 3 + 4, 4 + 5)
    print(str)
}
