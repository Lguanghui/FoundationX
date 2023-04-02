//
//  NSString+X.m
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/4/2.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#import "NSString+X.h"

@implementation NSString (X)

- (NSString *)x_addOrReplaceParams:(NSDictionary *)para {
    if (self.length <= 0) {
        return @"";
    }
    NSURL *url = [NSURL URLWithString:self];
    if (url == nil) {
        return @"";
    }
    NSMutableArray *newParams = [NSMutableArray array];
    for (NSString *key in para) {
        [newParams addObject:[NSURLQueryItem queryItemWithName:key value:para[key]]];
    }
    NSURLComponents *urlComponent = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSMutableArray *newQureyItems = [urlComponent.queryItems mutableCopy];
    if (!newQureyItems) {
        newQureyItems = [NSMutableArray array];
    }
    for (NSURLQueryItem *itemNew in newParams) {
        BOOL hasParam = NO;
        for (NSURLQueryItem *itemOld in urlComponent.queryItems) {
            if ([itemOld.name isEqualToString:itemNew.name]) {
                [newQureyItems replaceObjectAtIndex:[newQureyItems indexOfObject:itemOld] withObject:itemNew];
                hasParam = YES;
                break;
            }
        }

        if (!hasParam) {
            [newQureyItems addObject:itemNew];
        }
    }
    urlComponent.queryItems = newQureyItems;
    return urlComponent.URL.absoluteString;
}

@end
