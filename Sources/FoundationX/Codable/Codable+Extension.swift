//
//  Codable+Extension.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2022/12/15.
//  Copyright © 2022 Guanghui Liang. All rights reserved.
//

import Foundation

public extension Encodable {
    /// convert Encodable object to dictionary
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
