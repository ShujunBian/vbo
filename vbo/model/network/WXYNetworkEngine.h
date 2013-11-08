//
//  WXYNetworkEngine.h
//  vbo
//
//  Created by wxy325 on 10/22/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "MKNetworkKit.h"
#import "WXYBlock.h"

#define SHARE_NW_ENGINE [WXYNetworkEngine shareNetworkEngine]
@interface WXYNetworkEngine : MKNetworkEngine

+ (WXYNetworkEngine*)shareNetworkEngine;

- (MKNetworkOperation*)getHomeTimelineOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                     error:(ErrorBlock)errorBlock;

@end
