//
//  WXYCachedNetworkEngine.m
//  vbo
//
//  Created by wxy325 on 12/4/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYCachedNetworkEngine.h"
#import "UIImageView+MKNetworkKitAdditions.h"

@implementation WXYCachedNetworkEngine

+ (WXYCachedNetworkEngine*)shareCachedNetworkEngine
{
    static WXYCachedNetworkEngine* s_networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_networkEngine = [[WXYCachedNetworkEngine alloc] init];
        [s_networkEngine useCache];
    });
    return s_networkEngine;
}

- (int)cacheMemoryCost
{
    return 50;
}

@end
