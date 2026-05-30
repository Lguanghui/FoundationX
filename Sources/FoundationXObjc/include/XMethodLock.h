//
//  XMethodLock.h
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/9.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/// 检查方法是否锁定，如果已经锁定，直接返回，如果没有锁定，将方法锁定，并进入方法
#define XMethodLockedReturn()              \
    {                                      \
        if (XMethodIsLocked(self, _cmd)) { \
            return;                        \
        }                                  \
        XMethodLock(self, _cmd);         \
    }
#define XMarcoIsUnLock !XMethodIsLocked(self, _cmd)
#define XMarcoLock() XMethodLock(self, _cmd);
#define XMarcoUnLock() XMethodUnlock(self, _cmd);

/// 锁定方法
/// @param object 要锁定的对象， 一般传入 self
/// @param selector 要锁定的方法，一般传入 _cmd
void XMethodLock(id object, SEL selector);

/// 解锁方法
/// @param object 要解锁的对象， 一般传入 self
/// @param selector 要解锁的方法，一般传入 _cmd
void XMethodUnlock(id object, SEL selector);

/// 判断方法是否锁定
/// @param object 判断是否锁定的对象， 一般传入 self
/// @param selector 判断是否锁定的方法，一般传入 _cmd
BOOL XMethodIsLocked(id object, SEL selector);

NS_ASSUME_NONNULL_END
