//
//  WXYStatusTest.m
//  vbo
//
//  Created by wxy325 on 11/14/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WXYDataModel.h"

@interface WXYStatusTest : XCTestCase

@property (strong, nonatomic) Status* status;

@end

@implementation WXYStatusTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.status = [Status insertWithId:@(200) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.status.text = @"aaaa";
    self.status.createdAt = [NSDate date];
    [SHARE_DATA_MODEL saveCacheContext];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.status];
    [SHARE_DATA_MODEL saveCacheContext];
    
    [super tearDown];
}

- (void)testGetStatusById
{
    Status* status2 = [SHARE_DATA_MODEL getStatusById:200ll];
    XCTAssertEqualObjects(self.status, status2, @"Status不可用");
}

- (void)testStatusClass
{
    XCTAssert([self.status isKindOfClass:[Status class]], @"self.status应该为Status类");
}

@end
