//
//  Mirror+Extension.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/9.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

public extension Mirror {
    static func isOptional(_ any: Any) -> Bool {
        guard let style = Mirror(reflecting: any).displayStyle,
            style == .optional else { return false }
        return true
    }
}
