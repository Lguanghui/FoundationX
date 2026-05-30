//
//  FoundationXObjcTests.m
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/4/2.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

#import <XCTest/XCTest.h>

@import Foundation;
@import FoundationX;
@import FoundationXObjc;

@interface FoundationXObjcTests : XCTestCase

@end

@implementation FoundationXObjcTests

- (void)testSchemeParamReplace {
    NSString *testScheme = @"https://liangguanghui.site?test=false&hello=0";
    NSString *replacedScheme = [testScheme x_addOrReplaceParams:@{@"test": @"true", @"name": @"FoundationX"}];
    NSURLComponents *components = [NSURLComponents componentsWithString:replacedScheme];
    NSMutableDictionary<NSString *, NSString *> *queryValues = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *item in components.queryItems) {
        queryValues[item.name] = item.value;
    }

    XCTAssertEqualObjects(queryValues[@"test"], @"true");
    XCTAssertEqualObjects(queryValues[@"hello"], @"0");
    XCTAssertEqualObjects(queryValues[@"name"], @"FoundationX");
    XCTAssertEqualObjects([@"" x_addOrReplaceParams:@{@"test": @"true"}], @"");
}

- (void)testBlockRun {
    __block NSString *value = nil;
    void (^block)(NSString * str) = ^(NSString * str) {
        value = str;
    };
    
    XBlock_exec(block, @"hello")
    XCTAssertEqualObjects(value, @"hello");

    block = nil;
    XBlock_exec(block, @"released")
    XCTAssertEqualObjects(value, @"hello");
}

- (void)testMethodLockHandlesObjectLocks {
    NSObject *object = [[NSObject alloc] init];
    XCTAssertFalse(XMethodIsLocked(object, _cmd));
    XMethodLock(object, _cmd);
    XCTAssertTrue(XMethodIsLocked(object, _cmd));
    XMethodUnlock(object, _cmd);
    XCTAssertFalse(XMethodIsLocked(object, _cmd));
}

- (void)testNSURLFileSizeHelpers {
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *directory = [fileManager.temporaryDirectory URLByAppendingPathComponent:NSUUID.UUID.UUIDString isDirectory:YES];
    NSURL *fileURL = [directory URLByAppendingPathComponent:@"payload.txt"];
    NSURL *nestedDirectory = [directory URLByAppendingPathComponent:@"nested" isDirectory:YES];
    NSURL *nestedFileURL = [nestedDirectory URLByAppendingPathComponent:@"nested.txt"];

    XCTAssertTrue([fileManager createDirectoryAtURL:nestedDirectory withIntermediateDirectories:YES attributes:nil error:nil]);
    XCTAssertTrue([[@"hello" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:fileURL atomically:YES]);
    XCTAssertTrue([[@"world" dataUsingEncoding:NSUTF8StringEncoding] writeToURL:nestedFileURL atomically:YES]);

    XCTAssertEqual([fileURL x_fileSize], 5);
    XCTAssertEqual([nestedFileURL x_fileSize], 5);
    XCTAssertGreaterThanOrEqual([directory x_directorySize], 10);

    [fileManager removeItemAtURL:directory error:nil];
}

@end
