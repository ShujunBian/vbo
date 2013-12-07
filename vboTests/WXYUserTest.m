//
//  WXYUserTest.m
//  vbo
//
//  Created by wxy325 on 11/14/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXYDataModel.h"
#import "WXYLoginManager.h"

@interface WXYUserTest : XCTestCase

@property (strong, nonatomic) User* user;

@property (strong, nonatomic) Status* status;
@property (strong, nonatomic) Status* status2;
@property (strong, nonatomic) Status* status3;
@property (strong, nonatomic) Status* status4;
@end

@implementation WXYUserTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.user = [User insertWithId:@(200) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.status = [SHARE_DATA_MODEL getOrCreateStatusById:300];
    self.status2 = [SHARE_DATA_MODEL getOrCreateStatusById:301];
    self.status3 = [SHARE_DATA_MODEL getOrCreateStatusById:302];
    self.status4 = [SHARE_DATA_MODEL getOrCreateStatusById:303];
    [SHARE_DATA_MODEL saveCacheContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.user];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status2];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status3];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status4];
    [SHARE_DATA_MODEL saveCacheContext];
    [super tearDown];
    
}

- (void)testGetUserById
{
    User* u = [SHARE_DATA_MODEL getOrCreateUserById:200ll];
    XCTAssertEqualObjects(self.user, u, @"GetUserById有错");
}

- (void)testUserClass
{
#warning 暂无法解决
//    XCTAssert([self.user isKindOfClass:[User class]], @"self.user应该为User类");
}

- (void)testAddStatusObject
{
    self.status.createdAt = [NSDate dateWithTimeIntervalSince1970:100];
    self.status2.createdAt = [NSDate dateWithTimeIntervalSince1970:300];
    self.status3.createdAt = [NSDate dateWithTimeIntervalSince1970:200];
    self.status4.createdAt = [NSDate dateWithTimeIntervalSince1970:400];
    
    [self.user addStatusesObject:self.status];
    [self.user addStatusesObject:self.status2];
    [self.user addStatusesObject:self.status3];
    [self.user addStatusesObject:self.status4];
    [SHARE_DATA_MODEL saveCacheContext];
    NSOrderedSet* set = self.user.statuses;
    
    XCTAssertEqualObjects(self.status4, set[0], @"排序不正确");
    XCTAssertEqualObjects(self.status2, set[1], @"排序不正确");
    XCTAssertEqualObjects(self.status3, set[2], @"排序不正确");
    XCTAssertEqualObjects(self.status, set[3], @"排序不正确");
    
}
- (void)testAddStatuses
{
    self.status.createdAt = [NSDate dateWithTimeIntervalSince1970:100];
    self.status2.createdAt = [NSDate dateWithTimeIntervalSince1970:300];
    self.status3.createdAt = [NSDate dateWithTimeIntervalSince1970:200];
    self.status4.createdAt = [NSDate dateWithTimeIntervalSince1970:400];
    
    [self.user addStatusesObject:self.status];
    [self.user addStatusesObject:self.status2];
    NSMutableOrderedSet* orderSet = [[NSMutableOrderedSet alloc] initWithObjects:self.status3, self.status4, nil];
    [self.user addStatuses:orderSet];
    [SHARE_DATA_MODEL saveCacheContext];
    NSOrderedSet* set = self.user.statuses;
    XCTAssertEqualObjects(self.status4, set[0], @"排序不正确");
    XCTAssertEqualObjects(self.status2, set[1], @"排序不正确");
    XCTAssertEqualObjects(self.status3, set[2], @"排序不正确");
    XCTAssertEqualObjects(self.status, set[3], @"排序不正确");
}
/*
- (void)testUserAddTimeLine
{
    User* user = self.user;
    User* user2 = SHARE_LOGIN_MANAGER.currentUser;
//    [self.user addHomeTimeLineObject:self.status];

    [user2 addHomeTimeLineObject:self.status];
    [SHARE_DATA_MODEL saveCacheContext];
    [user2 removeHomeTimeLineObject:self.status];
    [SHARE_DATA_MODEL saveCacheContext];
}
 */
@end
