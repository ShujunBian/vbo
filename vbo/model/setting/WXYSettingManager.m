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
@synthesize castViewTableCellContentLabelFont = _castViewTableCellContentLabelFont;
@synthesize castViewTableCellBackgroundColor = _castViewTableCellBackgroundColor;
@synthesize castViewTableViewBackgroundColor = _castViewTableViewBackgroundColor;

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

#pragma mark - CastView Settings
- (UIFont *)castViewTableCellContentLabelFont
{
    if (!_castViewTableCellContentLabelFont) {
        _castViewTableCellContentLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:16];
    }
    return _castViewTableCellContentLabelFont;
}

- (UIColor *)castViewTableCellBackgroundColor {
    if (!_castViewTableCellBackgroundColor) {
        _castViewTableCellBackgroundColor = [UIColor colorWithRed:246.0 / 255.0 green:244.0 / 255.0 blue:240.0 / 255.0 alpha:1.0];
    }
    return _castViewTableCellBackgroundColor;
}

- (UIColor *)castViewTableViewBackgroundColor {
    if (!_castViewTableViewBackgroundColor) {
#warning 从设备型号读取颜色
        _castViewTableViewBackgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:130.0 / 255.0 blue:130.0 / 255.0 alpha:1.0];
    }
    return _castViewTableViewBackgroundColor;
}

@end
