//
//  WXYCachedNetworkEngine.h
//  vbo
//
//  Created by wxy325 on 12/4/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//



#import "MKNetworkKit.h"


//缓存network engine
//用于控制图片缓存
@interface WXYCachedNetworkEngine : MKNetworkEngine

+ (WXYCachedNetworkEngine*)shareCachedNetworkEngine;

@end
