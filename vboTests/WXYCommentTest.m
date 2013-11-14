//
//  WXYDataModelTest.m
//  vbo
//
//  Created by wxy325 on 11/13/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYDataModel.h"
#import <XCTest/XCTest.h>

@interface WXYCommentTest : XCTestCase

@property (strong, nonatomic) WXYDataModel* dataModel;
@property (strong, nonatomic) Comment* comment;

@end

@implementation WXYCommentTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.dataModel = SHARE_DATA_MODEL;
    
    self.comment = [SHARE_DATA_MODEL getCommentById:200ll];
//    self.comment = [Comment insertWithId:@(200) InContest:SHARE_DATA_MODEL.cacheManagedObjectContext];
    self.comment.text = @"aaaaz";
    [SHARE_DATA_MODEL saveCacheContext];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [SHARE_DATA_MODEL.cacheManagedObjectContext deleteObject:self.comment];
    [SHARE_DATA_MODEL saveCacheContext];
    [super tearDown];
    
}

- (void)testGetCommentById
{
    Comment* c = [SHARE_DATA_MODEL getCommentById:200ll];
    XCTAssertEqualObjects(self.comment, c, @"getCommentById不可用");
}


@end
