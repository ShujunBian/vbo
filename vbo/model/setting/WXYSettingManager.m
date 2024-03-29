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
#define kThemeColorKey @"THEME_COLOR"

#define COLOR_THEME_BLUE [UIColor colorWithRed:90.f/255.f green:198.f/255.f blue:255.f/255.f alpha:1.f]
#define COLOR_THEME_WHITE [UIColor colorWithRed:241.f/255.f green:241.f/255.f blue:242.f/255.f alpha:1.f]
#define COLOR_THEME_GREEN [UIColor colorWithRed:89.f/255.f green:227.f/255.f blue:0.f/255.f alpha:1.f]
#define COLOR_THEME_YELLOW [UIColor colorWithRed:255.f/255.f green:192.f/255.f blue:0.f/255.f alpha:1.f]
#define COLOR_THEME_RED [UIColor colorWithRed:255.f/255.f green:130.f/255.f blue:130.f/255.f alpha:1.f]


@interface WXYSettingManager ()

@property (strong, nonatomic) NSUserDefaults* userDefault;

@end

@implementation WXYSettingManager
@synthesize currentUserId = _currentUserId;
@synthesize testAccessToken = _testAccessToken;
@synthesize rootBarTintColor = _rootBarTintColor;
@synthesize castViewTableCellContentLabelFont = _castViewTableCellContentLabelFont;
@synthesize themeColorType = _themeColorType;
@synthesize themeColor = _themeColor;
@synthesize castViewTableCellBackgroundColor = _castViewTableCellBackgroundColor;
@synthesize castViewTableCellContentLabelTextColor = _castViewTableCellContentLabelTextColor;
@synthesize castViewTableCellTimeLabelColor = _castViewTableCellTimeLabelColor;
//@synthesize castViewTableViewBackgroundColor = _castViewTableViewBackgroundColor;

#pragma mark - Getter And Setter Method
#pragma mark
- (ThemeColorType)themeColorType
{
    if (!_themeColorType)
    {
        _themeColorType = [self.userDefault integerForKey:kThemeColorKey];
        if (!_themeColorType)
        {
            _themeColorType = ThemeColorTypeRed;
        }
    }
    return _themeColorType;
}
- (void)setThemeColor:(ThemeColorType)themeColorType
{
    _themeColorType = themeColorType;
    [self.userDefault setInteger:_themeColorType forKey:kThemeColorKey];
    [self.userDefault synchronize];

    switch (_themeColorType)
    {
        case ThemeColorTypeBlue:
            _themeColor = COLOR_THEME_BLUE;
            break;
        case ThemeColorTypeGreen:
            _themeColor = COLOR_THEME_GREEN;
            break;
        case ThemeColorTypeRed :
            _themeColor = COLOR_THEME_RED;
            break;
        case ThemeColorTypeWhite:
            _themeColor = COLOR_THEME_WHITE;
            break;
        case ThemeColorTypeYellow:
            _themeColor = COLOR_THEME_YELLOW;
            break;
    }
    
}
- (UIColor*)themeColor
{
    if (!_themeColor)
    {
        switch (self.themeColorType)
        {
            case ThemeColorTypeBlue:
                _themeColor = COLOR_THEME_BLUE;
                break;
            case ThemeColorTypeGreen:
                _themeColor = COLOR_THEME_GREEN;
                break;
            case ThemeColorTypeRed :
                _themeColor = COLOR_THEME_RED;
                break;
            case ThemeColorTypeWhite:
                _themeColor = COLOR_THEME_WHITE;
                break;
            case ThemeColorTypeYellow:
                _themeColor = COLOR_THEME_YELLOW;
                break;
        }
    }
    return _themeColor;
}

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

#pragma mark - Color
- (UIColor*)rootBarTintColor
{
    if (!_rootBarTintColor)
    {
        _rootBarTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
    }
    return _rootBarTintColor;
}
#pragma mark - CastView Settings
- (UIFont *)castViewTableCellContentLabelFont
{
#warning 设置字体单例有待重新完成
//    if (!_castViewTableCellContentLabelFont) {
        UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithName:@"Helvetica-Light" size:16];
        UIFontDescriptor* bodyFontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
        NSNumber* bodyFontSize = bodyFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute];
        UIFont* font = [UIFont fontWithDescriptor:fontDescriptor size:[bodyFontSize floatValue]];
//    }
    return font;
}

- (UIColor *)castViewTableCellBackgroundColor {
    if (!_castViewTableCellBackgroundColor) {
        _castViewTableCellBackgroundColor = [UIColor colorWithRed:246.0 / 255.0 green:244.0 / 255.0 blue:240.0 / 255.0 alpha:1.0];
    }
    return _castViewTableCellBackgroundColor;
}

- (UIColor *)castViewTableCellContentLabelTextColor {
    if (!_castViewTableCellContentLabelTextColor) {
        _castViewTableCellContentLabelTextColor = [UIColor colorWithRed:49.0 / 255.0 green:42.0 / 255.0 blue:37.0 / 255.0 alpha:1.0];
    }
    return _castViewTableCellContentLabelTextColor;
}

- (UIColor *)castViewTableCellTimeLabelColor {
    if (!_castViewTableCellTimeLabelColor) {
        _castViewTableCellTimeLabelColor = [UIColor colorWithRed:150.0 / 255.0 green:150.0 / 255.0 blue:150.0 / 255.0 alpha:1.0];
    }
    return _castViewTableCellTimeLabelColor;
}
/*
- (UIColor *)castViewTableViewBackgroundColor {
    if (!_castViewTableViewBackgroundColor) {
#warning 从设备型号读取颜色
        _castViewTableViewBackgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:130.0 / 255.0 blue:130.0 / 255.0 alpha:1.0];
    }
    return _castViewTableViewBackgroundColor;
}
*/

@end
