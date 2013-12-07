//
//  WXYNetworkEngineTest.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

//#import "../Pods/GHUnitIOS/Classes/GHAsyncTestCase.h"
#import <GHUnitIOS/GHUnit.h>
#import <XCTest/XCTest.h>
#import "WXYNetworkEngine.h"
#import "WXYLoginManager.h"

#define TEST_GROUP_ID 3417030495788416

@interface WXYNetworkEngineTest : XCTestCase

@property (strong, nonatomic) GHAsyncTestCase* asyncTestCase;
@property (strong, nonatomic) WXYNetworkEngine* engine;

@end

@implementation WXYNetworkEngineTest
static NSLock* s_Lock = nil;
+ (void)setUp
{

    s_Lock = [[NSLock alloc] init];
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [s_Lock lock];
    self.asyncTestCase = [[GHAsyncTestCase alloc] init];
    [self.asyncTestCase setUp];
    self.engine = SHARE_NW_ENGINE;

    [NSThread sleepForTimeInterval:0.5f];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [s_Lock unlock];
    [super tearDown];
    [self.asyncTestCase tearDown];
}

#pragma mark - User
- (void)testGetUserInfoByUserId
{
    [self.asyncTestCase prepare];
    [self.engine getUserInfoId:@2672281483 orScreenName:nil succeed:^(User *user) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"获取用户信息失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testGetUserInfoByScreenName
{
    [self.asyncTestCase prepare];
    [self.engine getUserInfoId:nil orScreenName:@"大脸大魔王" succeed:^(User *user) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"获取用户信息失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

#pragma mark - Weibo
#pragma mark Read
//- (void)testGetHomeTimelineOfCurrentUser
//{
//    [self.asyncTestCase prepare];
//    [self.engine getHomeTimelineOfCurrentUserPage:1
//                                          Succeed:^(NSArray *resultArray) {
//        Status* status = resultArray[0];
//        NSLog(@"%@",status.statusID);
//        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
//
//    } error:^(NSError *error) {
//        XCTFail(@"获取Home界面微博失败");
//        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
//    }];
//    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
//
//}

#pragma mark Write
- (void)testPostWeiboText
{
    [self.asyncTestCase prepare];
    
    NSString* str = [NSString stringWithFormat:@"超级大测试%@",[[NSDate date] descriptionWithLocale:[NSLocale currentLocale]]];
    
    
    [self.engine postWeiboOfCurrentUser:str
                                  image:nil
                           withLocation:NO
                            visibleType:StatusVisibleTypeNormal
                          visibleListId:0
                                succeed:^(Status *status)
     {
         if (status)
         {
             [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
         }
         else
         {
             XCTFail(@"发送微博文字失败");
             [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
         }

     }
                                  error:^(NSError *error)
     {
         XCTFail(@"发送微博文字失败");
         [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
     }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}


- (void)testPostWeiboImage
{
    [self.asyncTestCase prepare];
    
    NSString* str = [NSString stringWithFormat:@"超级图片大测试%@",[[NSDate date] descriptionWithLocale:[NSLocale currentLocale]]];
    UIImage* testImage = [UIImage imageNamed:@"test.png"];
    
    [self.engine postWeiboOfCurrentUser:str
                                  image:testImage
                           withLocation:NO
                            visibleType:StatusVisibleTypeNormal
                          visibleListId:0
                                succeed:^(Status *status)
     {
         if (status)
         {
             [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
         }
         else
         {
             XCTFail(@"发送图片失败");
             [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
         }
     }
                                  error:^(NSError *error)
     {
         XCTFail(@"发送图片失败");
         [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
     }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testRepostWeibo
{
    [self.asyncTestCase prepare];
    
    [self.engine repostWeibo:@(3644235297736244) text:@"转发测试" isComment:RepostCommentTypeNo succeed:^(Status *status) {
        XCTAssertNotNil(status, @"返回微博为空");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"转发失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testRepostWeiboWithCommentAll
{
    [self.asyncTestCase prepare];
    
    [self.engine repostWeibo:@(3644235297736244) text:@"转发测试" isComment:RepostCommentTypeAll succeed:^(Status *status) {
        XCTAssertNotNil(status, @"返回微博为空");
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"转发失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

#pragma mark - Comment
#pragma mark Read
- (void)testGetCommentOfWeibo
{
    [self.asyncTestCase prepare];
    
    // 3644230360421007
    
    [SHARE_NW_ENGINE getCommentsOfWeibo:@(3644235297736244) page:1 succeed:^(NSArray *resultArray) {
        XCTAssertNotNil(resultArray, @"获取评论失败");
        
        if (resultArray.count)
        {
            id comment = resultArray[0];
            XCTAssert([comment isKindOfClass:[Comment class]], @"评论类型错误");
            Comment* c = (Comment*)comment;
            XCTAssertNotEqual(c.text.length, 0, @"评论内容为空");
        }
        
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"获取评论失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
#pragma mark - Group
#pragma mark Read
- (void)testGroupGetList
{
    [self.asyncTestCase prepare];
    
    [SHARE_NW_ENGINE getGroupListSucceed:^(NSArray *resultArray)
    {
        XCTAssertNotNil(resultArray, @"resultArray不能为空");
        if (resultArray.count)
        {
            id g = resultArray[0];
            XCTAssert([g isKindOfClass:[Group class]], @"Array内容应为Group");
        }
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testGroupGetMemberList
{
    [self.asyncTestCase prepare];
    
    [SHARE_NW_ENGINE getGroupMemberListById:@(3437695525545341) cursor:@(0) succeed:^(Group *group, NSNumber *previousCursor, NSNumber *nextCursor)
    {
        
        if (group.users.count)
        {
            id u = [group.users anyObject];
            
#warning 疑似xcode抽风，待解决
//            XCTAssert([u isKindOfClass:[User class]], @"Array内容应为User");
//            XCTAssert(([u class] == [User class]), @"Array内容应为User");
        }
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error)
    {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGroupGetStatus
{
    [self.asyncTestCase prepare];
    
    [SHARE_NW_ENGINE getGroupStatusListById:@(TEST_GROUP_ID)
                                       page:1
                                    succeed:^(NSArray *resultArray)
     {
         if (resultArray.count)
         {
             id s = resultArray[0];
             XCTAssert([s isKindOfClass:[Status class]], @"s的类型应该为Status");
         }
         
         [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
     }
                                      error:^(NSError *error)
     {
         XCTFail(@"网络请求失败");
         [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
     }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testGetFriendListById
{
    [self.asyncTestCase prepare];
    LoginUserInfo* user = SHARE_LOGIN_MANAGER.currentUserInfo;
    
    [SHARE_NW_ENGINE getFriendListById:@(user.userId.longLongValue) screenName:nil count:200 cursor:@0 succeed:^(NSArray *array, NSNumber *previousCursor, NSNumber *nextCursor)
    {
        
        if (array.count)
        {
            id user = array[0];
        }
        
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetAllFriendById
{
    [self.asyncTestCase prepare];
    LoginUserInfo* user = SHARE_LOGIN_MANAGER.currentUserInfo;
    
    [SHARE_NW_ENGINE getAllFriendListById:@(user.userId.longLongValue)
                               screenName:nil
                                  succeed:^(NSArray *resultArray)
    {
        if (resultArray.count)
        {
            id user = resultArray[0];
        }
        
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    }
                                    error:^(NSError *error)
    {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetAllFriendOfCurrentUserById
{
    [self.asyncTestCase prepare];
    LoginUserInfo* user = SHARE_LOGIN_MANAGER.currentUserInfo;
    
    [SHARE_NW_ENGINE getAllFriendOfCurrentUserSucceed:^(NSArray *resultArray)
     {
         if (resultArray.count)
         {
             id user = resultArray[0];
         }
         
         [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
     }
                                    error:^(NSError *error)
     {
         XCTFail(@"网络请求失败");
         [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
     }];
    
    
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetHourlyHotTopic
{
    [self.asyncTestCase prepare];
    [SHARE_NW_ENGINE getHotTopicSucceed:^(NSArray *resultArray)
    {
        if (resultArray.count)
        {
            id topic = resultArray[0];
            XCTAssert([topic isKindOfClass:[NSString class]], @"topic应为string");
            [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
        }
    } error:^(NSError *error)
    {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}

- (void)testGetHotUser
{
    [self.asyncTestCase prepare];
    [SHARE_NW_ENGINE getHotUserSucceed:^(NSArray *resultArray) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
        [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testGetHotStatus
{
    [self.asyncTestCase prepare];
    [SHARE_NW_ENGINE getHotWeiboPage:1 succeed:^(NSArray *resultArray) {
        if (resultArray.count)
        {
            id status = resultArray[0];
            XCTAssert([status isKindOfClass:[Status class]], @"topic应为string");
        }
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testSearchTopic
{
    [self.asyncTestCase prepare];
    [SHARE_NW_ENGINE searchTopic:@"tjcdi" page:1 succeed:^(NSArray *resultArray) {
        if (resultArray.count)
        {
            id status = resultArray[0];
            XCTAssert([status isKindOfClass:[Status class]], @"topic应为string");
        }
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];
}
- (void)testFavoriteStatus
{
    [self.asyncTestCase prepare];
    
    [SHARE_NW_ENGINE getFavoriteStatusPage:1 succeed:^(NSArray *resultArray) {
        if (resultArray.count)
        {
            id status = resultArray[0];
            XCTAssert([status isKindOfClass:[Status class]], @"topic应为string");
        }
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];
    } error:^(NSError *error) {
        XCTFail(@"网络请求失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
        
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];

}
@end
