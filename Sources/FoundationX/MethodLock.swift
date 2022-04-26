//
//  MethodLock.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2022/4/26.
//  Copyright © 2022 Guanghui Liang. All rights reserved.
//

import Foundation
import ObjectiveC

fileprivate let selectorPrefix = "MethodLock"
fileprivate let lockValue = "lock"

fileprivate func aliasForSelector(selector: Selector) -> Selector {
    return NSSelectorFromString(selectorPrefix + "_" + NSStringFromSelector(selector))
}

public func methodLock(object: Any?, selector: Selector) {
    guard let object = object else {
        return
    }
    var aliasSelector = aliasForSelector(selector: selector)
    objc_setAssociatedObject(object, &aliasSelector, lockValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

public func methodUnlock(object: Any?, selector: Selector) {
    guard let object = object else {
        return
    }
    var aliasSelector = aliasForSelector(selector: selector)
    objc_setAssociatedObject(object, &aliasSelector, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

public func methodIsLocked(object: Any?, selector: Selector) -> Bool {
    guard let object = object else {
        return false
    }
    var aliasSelector = aliasForSelector(selector: selector)
    if let lock = objc_getAssociatedObject(object, &aliasSelector) as? String, lock == lockValue {
        return true
    }
    return false
}
