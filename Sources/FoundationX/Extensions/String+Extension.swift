//
//  File.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/12/18.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import Foundation

public extension String {
    /// Retrieve the character at a specific index from the string.
    subscript (_ index: Int) -> Character? {
        guard isEmpty == false && index < count && index >= 0 else {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

public extension Character {
    /// Convert the character to String.
    var stringValue: String {
        return String(self)
    }
}

public extension String {
    /// Append URL components from the given dict.
    ///
    /// - note: The string `self` should be a valid URL.
    func urlAddComponents(from dict: [String: String]) -> String {
        guard var components: URLComponents = URLComponents(string: self) else {
            return self
        }
        
        var queryItems = [URLQueryItem]()
        for (key, value) in dict {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let originalItems = components.queryItems {
            queryItems.append(contentsOf: originalItems)
        }
        
        components.queryItems = queryItems
        return components.url?.absoluteString ?? self
    }
}

public extension String {
    /// Remove the white spaces and newlines at the String's beginning or end.
    func trimWhitespacesAndNewlines() -> String {
          return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
