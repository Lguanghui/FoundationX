//
//  NSURL+File.h
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (File)

/// get file size from URL in **Bytes**
- (uint64_t)x_fileSize;

/// get directory size from URL in Bytes
- (uint64_t)x_directorySize;

@end

NS_ASSUME_NONNULL_END
