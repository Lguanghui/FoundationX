//
//  NSObject+Swizzle.h
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/11/13.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !TARGET_OS_WATCH

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

/// swizzle for `class` method
/// @param origSelector original selector
/// @param newSelector new selector
+ (void)swizzleClassMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

/// swizzle for `instance` method
/// @param origSelector original selector
/// @param newSelector new selector
- (void)swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END

#endif
