//
//  Logger.swift
//  FoundationX 
// 
//  Created by Guanghui Liang on 2023/3/8.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation
#if SPM_MODE
import FoundationX_Objc
#endif

open class XLogger {
    
    /// Whether to print in DEBUG mode only. Default is `true`.
    public static var onlyDEBUG: Bool = true
    
    /// Whether to print your personal message in a new line. Default is `true`.
    public static var newLineMode: Bool = true
    
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
    
    private static func _print(withFlags flags: [Any] = [], messages: String, pure: Bool, function: String) {
        if (Self.onlyDEBUG && ProductionMacro()) {
            return
        }
        
        var flags: [Any] = flags
        if newLineMode {
            flags.insert("◎", at: 0)
        }
        
        let dateString = dateFormatter.string(from: Date())
        let file: String = #file
        let line: Int = #line
        let extraMessage: String = pure ? "" : "\(dateString) - \(_sourceFileName(file)).\(function) [line \(line)]"
        
        let _flags: [Any] = flags.compactMap({ String(describing: $0)})
        var compactFlagStr = _flags.reduce("") { partialResult, next in
            return String(partialResult).isEmpty ? "\(next)" : "\(partialResult)" + " " + "\(next)"
        }
        compactFlagStr = compactFlagStr.isEmpty == false ? compactFlagStr + " " : ""
        
        if newLineMode {
            print(compactFlagStr + extraMessage)
            print("╰─>", messages)
        } else {
            print(compactFlagStr + extraMessage, messages)
        }
    }
}

// MARK: - Public

public extension XLogger {
    /// Print messages in terminal.
    ///
    ///     XLogger.printMessage("This is a message with my custom flags.", ["🍎", "🍊"])
    ///     // it will print:
    ///     // 🍎 🍊 2023-03-09 17:27:23 - Logger.swift._print(withFlags:messages:pure:) [line 36] This is a message with my custom flags.
    ///
    /// - Parameters:
    ///   - messages: your messages
    ///   - flags: custom flags at printed message's beginning. Default is empty.
    ///   - pure: if `true`, some extra messages, like `#file`, `#function`, won't be printed. Default is `false`.
    class func log(_ messages: Any..., flags: [Any] = [], pure: Bool = false, function: String = #function) {
        Self._print(withFlags: flags, messages: messages.compactMap({ String(describing: $0) }).joined(separator: " "), pure: pure, function: function)
    }
}
