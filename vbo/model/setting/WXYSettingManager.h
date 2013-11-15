//
//  WXYSettingManager.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SHARE_SETTING_MANAGER [WXYSettingManager shareSettingManager]

typedef enum
{
    ThemeColorTypeBlue = 1,
    ThemeColorTypeWhite = 2,
    ThemeColorTypeGreen = 3,
    ThemeColorTypeYellow = 4,
    ThemeColorTypeRed = 5
} ThemeColorType;


@interface WXYSettingManager : NSObject

@property (copy, nonatomic) NSString* currentUserId;

@property (copy, nonatomic) NSString* testAccessToken;

//@property (nonatomic, strong,readonly) UIFont * castViewTableCellContentLabelFont;
#pragma mark - castViewSettings
@property (nonatomic, strong, readonly) UIColor * castViewTableCellContentLabelTextColor;
@property (nonatomic, strong, readonly) UIFont * castViewTableCellContentLabelFont;
@property (nonatomic, strong, readonly) UIColor * castViewTableCellBackgroundColor;
@property (nonatomic, strong, readonly) UIColor * castViewTableCellTimeLabelColor;

//@property (nonatomic, strong, readonly) UIColor * castViewTableViewBackgroundColor;

@property (assign, nonatomic) ThemeColorType themeColorType;
@property (readonly, nonatomic) UIColor* themeColor;

+ (WXYSettingManager*)shareSettingManager;

//Init Method
- (id)init;

//Color
@property (strong, nonatomic, readonly) UIColor* rootBarTintColor;

@end
