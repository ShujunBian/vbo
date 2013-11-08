//
//  WXYSettingManager.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYSettingManager.h"


#define kCurrentUserIdKey @"CURRENT_USER_ID"
#define kTestAccessTokenKey @"TEST_ACCESS_TOKEN"

@interface WXYSettingManager ()

@property (strong, nonatomic) NSUserDefaults* userDefault;

@end

@implementation WXYSettingManager
@synthesize currentUserId = _currentUserId;
@synthesize testAccessToken = _testAccessToken;
#pragma mark - Getter And Setter Method
#pragma mark
- (NSString*)currentUserId
{
    if (!_currentUserId)
    {
        _currentUserId = [self.userDefault stringForKey:kCurrentUserIdKey];
    }
    return _currentUserId;
}
- (void)setCurrentUserId:(NSString *)loginUserId
{
    _currentUserId = loginUserId;
    if (_currentUserId)
    {
        [self.userDefault setObject:_currentUserId forKey:kCurrentUserIdKey];
    }
    else
    {
        [self.userDefault removeObjectForKey:kCurrentUserIdKey];
    }
    [self.userDefault synchronize];
}

- (NSString*)testAccessToken
{
    if (!_testAccessToken)
    {
        _testAccessToken = [self.userDefault stringForKey:kTestAccessTokenKey];
    }
    return _testAccessToken;
}

- (void)setTestAccessToken:(NSString *)testAccessToken
{
    _testAccessToken = testAccessToken;
    if (_testAccessToken)
    {
        [self.userDefault setObject:_testAccessToken forKey:kTestAccessTokenKey];
    }
    else
    {
        [self.userDefault removeObjectForKey:kTestAccessTokenKey];
    }
    [self.userDefault synchronize];
}

#pragma mark - Static Method
+ (WXYSettingManager*)shareSettingManager
{
    static WXYSettingManager* s_settingEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_settingEngine = [[WXYSettingManager alloc] init];
    });
    return s_settingEngine;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.userDefault = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

@end
