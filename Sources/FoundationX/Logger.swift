//
//  Logger.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/8.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

open class Logger {
    private static let dateFormatter = DateFormatter().then({ formatter in
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    })
    
    public static func printMessage(_ messages: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        let dateString = dateFormatter.string(from: Date())
        print("[\(dateString) - \(sourceFileName(file)).\(function):\(line)]", messages)
    }
   
    private static func sourceFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }
}
