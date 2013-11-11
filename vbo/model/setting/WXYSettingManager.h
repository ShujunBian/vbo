//
//  WXYSettingManager.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SHARE_SETTING_MANAGER [WXYSettingManager shareSettingManager]

@interface WXYSettingManager : NSObject

@property (copy, nonatomic) NSString* currentUserId;

@property (copy, nonatomic) NSString* testAccessToken;

#pragma mark - castViewSettings
@property (nonatomic, strong, readonly) UIFont * castViewTableCellContentLabelFont;
@property (nonatomic, strong, readonly) UIColor * castViewTableCellBackgroundColor;
@property (nonatomic, strong, readonly) UIColor * castViewTableViewBackgroundColor;

+ (WXYSettingManager*)shareSettingManager;


- (id)init;
@end
