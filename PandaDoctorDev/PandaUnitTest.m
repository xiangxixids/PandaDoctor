//
//  PandaUnitTest.m
//  PandaDoctor
//
//  Created by xiangxixids on 14/7/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UtilTool.h"

@interface PandaUnitTest : XCTestCase

@end

@implementation PandaUnitTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    NSLog(@"testExample");
    XCTAssert(YES, @"Pass");
}

- (void)testCase1{
    NSLog(@"testCase1");
}

-(void)testFileSaveAndRead{
    
    NSLog([UtilTool getRootPath]);
    NSLog([UtilTool getDocumentPath]);
    NSString *content = [NSString stringWithFormat:@"this is a content"];
    NSString *fileName = [NSString stringWithFormat:@"testFile"];
    NSData *fileContent = nil;
    if ([UtilTool saveFileInDocument:fileName content:[content dataUsingEncoding:NSUTF8StringEncoding]]) {
        NSLog(@"saveFile success!");
    }else{
        NSLog(@"saveFile failed!");
    }
    
    if ([UtilTool fileExistInDocument:fileName]) {
        fileContent = [UtilTool readFileInDocument:fileName];
        NSLog(@"fileContent : %@", [[NSString alloc]initWithData:fileContent encoding:NSUTF8StringEncoding]);
    }else{
        NSLog(@"%@ does not exist!!",fileName);
    }
    
    
    
    NSString *documentPath = [UtilTool getDocumentPath];
    NSString *testFileName = [NSString stringWithFormat:@"%@/%@", documentPath, fileName];
    
    if ([UtilTool saveFileToPath:documentPath path:fileName content:[content dataUsingEncoding:NSUTF8StringEncoding]]) {
        NSLog(@"save file success!!");
    }else{
        NSLog(@"save file failed!!");
    }
    
    if ([UtilTool fileExist:testFileName]) {
        NSLog(@"testFileName is exist!!");
        NSData *content = [UtilTool readFile:fileName path:documentPath];
        NSLog(@"%@", [[NSString alloc]initWithData:content encoding:NSUTF8StringEncoding]);
    }else{
        NSLog(@"can not find the testFileName");
    }
    
    NSLog(@"test end================");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSLog(@"test performance");
    }];
}

@end
