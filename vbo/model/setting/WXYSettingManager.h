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

+ (WXYSettingManager*)shareSettingManager;


- (id)init;
@end
