//
//  XCommonDefines.h
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/9.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#ifndef Header_h
#define Header_h

@import Foundation;

// MARK: - DLog

#if DEBUG || TEST_DEBUG
#    define DLog(fmt, ...) \
        NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#    define DLog(fmt, ...)
#endif

// MARK: - Weak/Strong self

/// typedef weak self
#define XWeak(type) __weak __typeof(&*type) weak##type = type

/// typedef strong self
#define XStrong(type) __strong __typeof(&*type) type = weak##type

// MARK: - Valid Check

/// valid NSString check
#define NSStringCheck(var) (ClassCheck(var, NSString) && (((NSString *)var).length > 0))

/// valid NSArray check
#define NSArrayCheck(var) (ClassCheck(var, NSArray) && (((NSArray *)var).count > 0))

// MARK: - Environment

#if (defined DEBUG) || TEST_DEBUG
#    define PRODUCTION 0
#else
#    define PRODUCTION 1
#endif

// MARK: - For Swift
NS_INLINE BOOL ProductionMacro(void) {
    return PRODUCTION;
}

#endif /* Header_h */
