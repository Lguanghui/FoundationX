//
//  XLogger.swift
//  FoundationX
//
//  Created by Guanghui Liang on 2023/3/8.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public enum XLogger {
    /// Logs are emitted only when FoundationX is built using the Debug configuration.
    @available(*, deprecated, message: "XLogger now emits logs only in Debug builds.")
    public static let onlyDEBUG = true

    /// Context and messages are emitted on separate lines.
    @available(*, deprecated, message: "XLogger now always emits contextual logs on two lines.")
    public static let newLineMode = true

    private static let lock = NSLock()
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    /// Prints an empty message in Debug builds.
    public static func log(flags: [Any] = [], pure: Bool = false, fileID: StaticString = #fileID, function: String = #function, line: UInt = #line) {
        #if DEBUG
        emit(message: "", flags: flags, pure: pure, fileID: fileID, function: function, line: line)
        #endif
    }

    /// Prints a value in Debug builds. The value is evaluated lazily, so Release builds avoid description work.
    public static func log<T>(
        _ message: @autoclosure () -> T,
        flags: [Any] = [],
        pure: Bool = false,
        fileID: StaticString = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if DEBUG
        emit(message: String(describing: message()), flags: flags, pure: pure, fileID: fileID, function: function, line: line)
        #endif
    }

    /// Prints multiple values in Debug builds.
    ///
    /// Prefer string interpolation with the single-message overload when Release-build evaluation cost matters.
    public static func log(
        _ firstMessage: Any,
        _ secondMessage: Any,
        _ remainingMessages: Any...,
        flags: [Any] = [],
        pure: Bool = false,
        fileID: StaticString = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        #if DEBUG
        let messages = [firstMessage, secondMessage] + remainingMessages
        let message = messages.map { String(describing: $0) }.joined(separator: " ")
        emit(message: message, flags: flags, pure: pure, fileID: fileID, function: function, line: line)
        #endif
    }

    private static func emit(message: String, flags: [Any], pure: Bool, fileID: StaticString, function: String, line: UInt) {
        lock.lock()
        defer { lock.unlock() }

        let timestamp = dateFormatter.string(from: Date())
        let output = formattedMessage(
            message: message,
            flags: flags.map { String(describing: $0) },
            pure: pure,
            fileID: String(describing: fileID),
            function: function,
            line: line,
            timestamp: timestamp
        )
        Swift.print(output)
    }

    static func formattedMessage(
        message: String,
        flags: [String],
        pure: Bool,
        fileID: String,
        function: String,
        line: UInt,
        timestamp: String
    ) -> String {
        guard !pure else {
            return message
        }

        let fileName = fileID.split(separator: "/").last.map(String.init) ?? fileID
        let prefix = (["◎"] + flags).joined(separator: " ")
        return "\(prefix) \(timestamp) - \(fileName).\(function) [line \(line)]\n╰─> \(message)"
    }
}
