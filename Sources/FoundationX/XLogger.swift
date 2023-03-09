//
//  Logger.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/8.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

#if SPM_MODE
import FoundationX_Objc
#endif

open class XLogger {
    
    /// Whether to print in DEBUG mode only. Default is `true`.
    public static var onlyDEBUG: Bool = true
    
    init() { }
    
    convenience init(flags: Any...) {
        self.init()
        self.flags = flags
    }
    
    private var flags: [Any] = []
    
    private static let dateFormatter = DateFormatter().then({ formatter in
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    })
    
    private static func _sourceFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }
    
    private static func _print(withFlags flags: [Any] = [], messages: String, pure: Bool) {
        if (Self.onlyDEBUG && ProductionMacro()) {
            return
        }
        
        let dateString = dateFormatter.string(from: Date())
        let file: String = #file
        let function: String = #function
        let line: Int = #line
        let extraMessage: String = pure ? "" : "\(dateString) - \(_sourceFileName(file)).\(function) [line \(line)]"
        
        let _flags: [Any] = flags.compactMap({ String(describing: $0)})
        let compactFlagStr = _flags.reduce("") { partialResult, next in
            return String(partialResult).isEmpty ? "\(next)" : "\(partialResult)" + " " + "\(next)"
        }
        
        if compactFlagStr.isEmpty {
            print(extraMessage, messages)
        } else {
            print(compactFlagStr, extraMessage, messages)
        }
    }
}

// MARK: - Public

public extension XLogger {
    /// Print messages with **custom flags** at beginning.
    ///
    ///     Logger.withFlag("🍎", "🍊").printMessage("This is a message with my custom flags.")
    ///     // it prints 🍎 🍊 2023-03-09 17:27:23 - Logger.swift._print(withFlags:messages:pure:) [line 36] This is a message with my custom flags.
    ///
    /// - Parameter flags: custom flags
    @discardableResult
    static func withFlag(_ flags: Any...) -> XLogger {
        let logger = XLogger(flags: flags)
        logger.flags = flags
        return logger
    }
    
    /// Print messages in terminal.
    /// - Parameters:
    ///   - messages: your messages
    ///   - pure: if `true`, some extra messages, like `#file`, `#function`, won't be printed. Default is `false`.
    static func printMessage(_ messages: Any..., pure: Bool = false) {
        Self._print(messages: messages.compactMap({ String(describing: $0) }).joined(separator: " "), pure: pure)
    }
    
    /// Print messages in terminal.
    /// - Parameters:
    ///   - messages: your messages
    ///   - pure: if `true`, some extra messages, like `#file`, `#function`, won't be printed. Default is `false`.
    func printMessage(_ messages: Any..., pure: Bool = false) {
        Self._print(withFlags: flags, messages: messages.compactMap({ String(describing: $0) }).joined(separator: " "), pure: pure)
    }
}
