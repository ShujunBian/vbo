//
//  WXYGroupTest.m
//  vbo
//
//  Created by wxy325 on 11/15/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXYDataModel.h"

#define TEST_GROUP_ID 200ll

@interface WXYGroupTest : XCTestCase

@property (strong, nonatomic) Group* group;

@end

@implementation WXYGroupTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.group = [Group insertWithId:@(TEST_GROUP_ID) inContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.group.name = @"aaa";
    [SHARE_DATA_MODEL saveCacheContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.group];
    [SHARE_DATA_MODEL saveCacheContext];
    [super tearDown];
}

- (void)testGetGroupById
{
    Group* g = [SHARE_DATA_MODEL getGroupById:TEST_GROUP_ID];
    XCTAssertEqualObjects(self.group, g, @"获取的group不对");
}
@end
