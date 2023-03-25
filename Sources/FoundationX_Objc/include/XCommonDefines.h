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

// MARK: - Target

#if TARGET_OS_OSX
    #define X_MACOS 1
#else
    #define X_MACOS 0
#endif

#if TARGET_OS_IOS
    #define X_IOS 1
#else
    #define X_IOS 0
#endif

#if TARGET_OS_TV
    #define X_TV 1
#else
    #define X_TV 0
#endif

#if TARGET_OS_WATCH
    #define X_WATCH 1
#else
    #define X_WATCH 0
#endif

// MARK: - API Visibility

/// defalut public API
#define PUBLIC_API __attribute__((visibility("default")))

/// internal API
#define INTERNAL_API __attribute__((visibility("internal")))

/// hidden API
#define HIDDEN_API __attribute__((visibility("hidden")))

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

// MARK: - Async Safe

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)               \
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {                        \
        block();                                          \
    } else {                                              \
        dispatch_async(dispatch_get_main_queue(), block); \
    }
#endif

// MARK: - For Swift
NS_INLINE BOOL ProductionMacro(void) {
    return PRODUCTION;
}

#endif /* Header_h */
