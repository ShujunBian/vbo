//
//  WXYLoginManager.h
//  vbo
//
//  Created by wxy325 on 11/19/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserInfo.h"

/*
 *本类用于管理登陆过用户的Access Token及其它相关信息
 *所有信息加密保存
 */

#define SHARE_LOGIN_MANAGER [WXYLoginManager shareLoginManager]

@interface WXYLoginManager : NSObject


+ (WXYLoginManager*)shareLoginManager;

@property (readonly, nonatomic) NSArray* loginUserList; //内容为LoginUserInfo,自动将当前登陆用户调整到第一
@property (readonly, nonatomic) LoginUserInfo* currentUserInfo;

@end
