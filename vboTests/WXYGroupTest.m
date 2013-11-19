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
#define TEST_USER1_ID 100ll
#define TEST_USER2_ID 101ll
#define TEST_STATUS1_ID 103ll
#define TEST_STATUS2_ID 104ll

@interface WXYGroupTest : XCTestCase

@property (strong, nonatomic) Group* group;

@property (strong, nonatomic) User* user1;
@property (strong, nonatomic) User* user2;

@property (strong, nonatomic) Status* status1;
@property (strong, nonatomic) Status* status2;

@end

@implementation WXYGroupTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.group = [Group insertWithId:@(TEST_GROUP_ID) inContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.user1 = [User insertWithId:@(TEST_USER1_ID) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.user2 = [User insertWithId:@(TEST_USER2_ID) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.status1 = [Status insertWithId:@(TEST_STATUS1_ID) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.status1.text = @"bbb";
    self.status2 = [Status insertWithId:@(TEST_STATUS2_ID) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.status2.text = @"ccc";
    self.status1.createdAt = [NSDate date];
    self.status2.createdAt = [NSDate date];
    
    self.group.name = @"aaa";
    [SHARE_DATA_MODEL saveCacheContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.group];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.user1];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.user2];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status1];
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status2];
    
    
    [SHARE_DATA_MODEL saveCacheContext];
    [super tearDown];
}

- (void)testGetGroupById
{
    Group* g = [SHARE_DATA_MODEL getGroupById:TEST_GROUP_ID];
    XCTAssertEqualObjects(self.group, g, @"获取的group不对");
}

- (void)testAddUsersObject
{
    [self.group addUsersObject:self.user1];
    [self.group addUsersObject:self.user2];
    XCTAssertEqual(self.group.users.count, (NSUInteger)2, @"user个数应为2");

}
- (void)testAddUsers
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.user1, self.user2, nil];
    [self.group addUsers:set];
    XCTAssertEqual(self.group.users.count, (NSUInteger)2, @"user个数应为2");
}
- (void)testRemoveUsersObject
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.user1, self.user2, nil];
    [self.group addUsers:set];
    [self.group removeUsersObject:self.user1];
    User* u = [self.group.users anyObject];
    XCTAssertEqualObjects(u, self.user2, @"删除不正确");
}
- (void)testRemoveUsers
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.user1, self.user2, nil];
    [self.group addUsersObject:self.user1];
    [self.group addUsersObject:self.user2];
    [self.group removeUsers:set];
    XCTAssertEqual(self.group.users.count, (NSUInteger)0, @"user个数应为0");
}

- (void)testGroupClass
{
    XCTAssert([self.group isKindOfClass:[Group class]], @"self.group应该为Group类");
}

- (void)testAddStatusesObject
{
    [self.group addStatusesObject:self.status1];
    [self.group addStatusesObject:self.status2];
    XCTAssertEqual(self.group.statuses.count, (NSUInteger)2, @"statuses个数应为2");
}

- (void)testAddStatuses
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.status1, self.status2, nil];
    [self.group addStatuses:set];
    XCTAssertEqual(self.group.statuses.count, (NSUInteger)2, @"statuses个数应为2");
}

- (void)testRemoveStatusesObject
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.status1, self.status2, nil];
    [self.group addStatuses:set];
    [self.group removeStatusesObject:self.status1];
    id s = [self.group.statuses anyObject];
    XCTAssertEqualObjects(s, self.status2, @"s应该为self.status2");
}
- (void)testRmemoveStatuses
{
    [self.group addStatusesObject:self.status1];
    [self.group addStatusesObject:self.status2];
    NSSet* set = [[NSSet alloc] initWithObjects:self.status1, self.status2, nil];
    [self.group removeStatuses:set];
        XCTAssertEqual(self.group.statuses.count, (NSUInteger)0, @"statuses个数应为0");
}
- (void)testGroupStatusedClass
{
    NSSet* set = [[NSSet alloc] initWithObjects:self.status1, self.status2, nil];
    [self.group addStatuses:set];
    id s = [self.group.statuses anyObject];
    XCTAssert([s isKindOfClass:[Status class]], @"group.statuses中应该为Status");
}

@end
