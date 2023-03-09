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
