//
//  NSURL+File.m
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/3/26.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#import "NSURL+File.h"

@implementation NSURL (File)

- (uint64_t)x_fileSize {
    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:self.path isDirectory:&isDir];
    if (isDir)
        return [self x_directorySize];
    else
        return (uint64_t)[[[[NSFileManager defaultManager] attributesOfItemAtPath:self.path error:nil] objectForKey:NSFileSize] unsignedIntegerValue];
}

- (uint64_t)x_directorySize {
    uint64_t result = 0;
    NSArray *properties = @[NSURLLocalizedNameKey, NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:self includingPropertiesForKeys:properties options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    for (NSURL *url in files) {
        result += [url x_fileSize];
    }

    return result;
}

@end
