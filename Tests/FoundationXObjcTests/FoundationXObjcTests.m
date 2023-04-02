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
@import FoundationX_Objc;

@interface FoundationXObjcTests : XCTestCase

@end

@implementation FoundationXObjcTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSchemeParamReplace {
    NSString *testScheme = @"https://liangguanghui.site?test=false&hello=0";
    NSString *replacedScheme = [testScheme x_addOrReplaceParams:@{@"test": @"true"}];
    DLog(@"%@", replacedScheme); // output: https://liangguanghui.site?test=true&hello=0
}

@end
