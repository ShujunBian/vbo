//
//  WXYLoginUserManagerTest.m
//  vbo
//
//  Created by wxy325 on 11/20/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WXYLoginManager.h"

@interface WXYLoginManagerTest : XCTestCase

@property (strong, nonatomic) WXYLoginManager* manager;

@property (strong, nonatomic) LoginUserInfo* info1;
@property (strong, nonatomic) LoginUserInfo* info2;
@property (strong, nonatomic) LoginUserInfo* info3;

@end

@implementation WXYLoginManagerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    self.manager = SHARE_LOGIN_MANAGER;
    
    self.info1 = [[LoginUserInfo alloc] init];
    self.info1.userId = @"testUserId1";
    self.info1.userName = @"testUserName1";
    self.info1.accessToken = @"testAccessToken1";
    self.info1.expireDate = [NSDate dateWithTimeIntervalSince1970:10000];
    
    self.info2 = [[LoginUserInfo alloc] init];
    self.info2.userId = @"testUserId2";
    self.info2.userName = @"testUserName2";
    self.info2.accessToken = @"testAccessToken2";
    self.info2.expireDate = [NSDate dateWithTimeIntervalSince1970:1000];
    
    self.info3 = [[LoginUserInfo alloc] init];
    self.info3.userId = @"testUserId3";
    self.info3.userName = @"testUserName3";
    self.info3.accessToken = @"testAccessToken3";
    self.info3.expireDate = [NSDate dateWithTimeIntervalSince1970:30000];
    
    
    [self.manager loginUser:self.info1];
    [self.manager loginUser:self.info2];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [self.manager removeUserInfo:self.info1.userId];
    [self.manager removeUserInfo:self.info2.userId];
    [self.manager removeUserInfo:self.info3.userId];
}

- (void)testUserLogin
{
    [self.manager loginUser:self.info3];
    XCTAssertEqualObjects(self.manager.currentUserInfo, self.info3, @"当前用户应为info3");
}
- (void)testChangeUser
{
    [self.manager loginUser:self.info3];
    if ([self.manager changeUser:self.info2.userId])
    {
        XCTAssertEqualObjects(self.manager.currentUserInfo, self.info2, @"当前用户应为info2");
    }
}
- (void)testRemoveUser
{
    int preNumber = self.manager.loginUserList.count;
    [self.manager removeUserInfo:self.info1.userId];
    [self.manager removeUserInfo:self.info2.userId];
    int postNumber = self.manager.loginUserList.count;
    XCTAssertEqual((preNumber - postNumber), 2, @"应该删除了2个info");
}

@end
