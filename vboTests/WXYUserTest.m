//
//  WXYUserTest.m
//  vbo
//
//  Created by wxy325 on 11/14/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXYDataModel.h"

@interface WXYUserTest : XCTestCase

@property (strong, nonatomic) User* user;

@end

@implementation WXYUserTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.user = [User insertWithId:@(200) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    [SHARE_DATA_MODEL saveCacheContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.user];
    [SHARE_DATA_MODEL saveCacheContext];
    [super tearDown];
    
}

- (void)testGetUserById
{
    User* u = [SHARE_DATA_MODEL getUserById:200ll];
    XCTAssertEqualObjects(self.user, u, @"GetUserById有错");
}

- (void)testUserClass
{
#warning 暂无法解决
    XCTAssert([self.user isKindOfClass:[User class]], @"self.user应该为User类");
}
@end
