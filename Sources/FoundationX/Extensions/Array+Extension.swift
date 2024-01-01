//
//  Array+Extension.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public extension Array {
    
    /// get element of array safely without 'out of bounds'.
    subscript (safe index: Int) -> Element? {
        guard index >= 0,self.count > index else {
            return nil
        }
        return self[index]
    }
    
}
