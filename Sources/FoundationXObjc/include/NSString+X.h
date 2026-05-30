//
//  NSString+X.h
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/4/2.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (X)

/// Add parameters to the scheme, overwrite if the parameter exists.
/// - Parameter para: parameters
- (NSString *)x_addOrReplaceParams:(NSDictionary *)para;

@end

NS_ASSUME_NONNULL_END
