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

@interface WXYNetworkEngineTest : XCTestCase

@property (strong, nonatomic) GHAsyncTestCase* asyncTestCase;
@property (strong, nonatomic) WXYNetworkEngine* engine;

@end

@implementation WXYNetworkEngineTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.asyncTestCase = [[GHAsyncTestCase alloc] init];
    [self.asyncTestCase setUp];
    self.engine = SHARE_NW_ENGINE;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [self.asyncTestCase tearDown];
}

- (void)testGetHomeTimelineOfCurrentUser
{
    [self.asyncTestCase prepare];
    [self.engine getHomeTimelineOfCurrentUserSucceed:^(NSArray *resultArray) {
        [self.asyncTestCase notify:kGHUnitWaitStatusSuccess];

    } error:^(NSError *error) {
        XCTFail(@"获取Home界面微博失败");
        [self.asyncTestCase notify:kGHUnitWaitStatusFailure];
    }];
    [self.asyncTestCase waitForStatus:kGHUnitWaitStatusSuccess timeout:kMKNetworkKitRequestTimeOutInSeconds];

}

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


@end
