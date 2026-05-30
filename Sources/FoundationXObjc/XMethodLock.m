//
//  XMethodLock.m
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/9.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#import "XMethodLock.h"
#import <objc/runtime.h>

static NSString *kLockValue = @"lock";
static NSString *kSelectorPrefix = @"XMethod";

static SEL _aliasForSelector(SEL selector) {
    return NSSelectorFromString([kSelectorPrefix stringByAppendingFormat:@"_%@", NSStringFromSelector(selector)]);
}

void XMethodLock(id object, SEL selector) {
    if (object == nil) {
        return;
    }
    objc_setAssociatedObject(object, _aliasForSelector(selector), kLockValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void XMethodUnlock(id object, SEL selector) {
    if (object == nil) {
        return;
    }
    objc_setAssociatedObject(object, _aliasForSelector(selector), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

BOOL XMethodIsLocked(id object, SEL selector) {
    if (object == nil) {
        return NO;
    }
    NSString *lock = objc_getAssociatedObject(object, _aliasForSelector(selector));
    return [lock isKindOfClass:[NSString class]] && [lock isEqualToString:kLockValue];
}
