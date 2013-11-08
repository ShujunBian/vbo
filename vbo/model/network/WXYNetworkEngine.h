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

/*! 获取当前登录用户及其所关注用户的最新微博
 * \param succeedBlock 网络请求成功处理block，block参数NSArray的内容为Status
 * \param errorBlock 网络请求失败处理block
 * \returns 当前网络请求Operation
 */
- (MKNetworkOperation*)getHomeTimelineOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                     error:(ErrorBlock)errorBlock;

@end
