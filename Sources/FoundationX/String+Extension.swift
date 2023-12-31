//
//  File.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/12/18.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public extension String {
    subscript (_ index: Int) -> Character? {
        guard isEmpty == false && index < count else {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

public extension Character {
    var stringValue: String {
        return String(self)
    }
}
