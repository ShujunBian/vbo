//
//  WXYNetworkEngine.h
//  vbo
//
//  Created by wxy325 on 10/22/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "MKNetworkKit.h"
#import "WXYBlock.h"
#import "WXYDataModel.h"

#define SHARE_NW_ENGINE [WXYNetworkEngine shareNetworkEngine]



@interface WXYNetworkEngine : MKNetworkEngine

+ (WXYNetworkEngine*)shareNetworkEngine;


///////////////微博接口
////////读取

/*! 获取当前登录用户及其所关注用户的最新微博
 * \param succeedBlock 网络请求成功处理block，block参数NSArray的内容为Status
 * \param errorBlock 网络请求失败处理block
 * \returns 当前网络请求Operation
 */
- (MKNetworkOperation*)getHomeTimelineOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                     error:(ErrorBlock)errorBlock;
////////写入
#warning fLocation暂不实现
/*! 发送微博
 * \param content 微博内容
 * \param weiboImage 微博图片，若无图则传nil
 * \param fLocation 是否发送地理位置信息
 * \param visibleType 微博可见性
 * \param listId 可见性为分组时，传分组标号。其他情况随便传，无视
 * \param succeedBlock 网络请求成功处理block，block参数Status为成功发送的微博
 * \param errorBlock 网络请求失败处理block
 * \returns 当前网络请求Operation
 */
- (MKNetworkOperation*)postWeiboOfCurrentUser:(NSString*)content
                                        image:(UIImage*)weiboImage
                                 withLocation:(BOOL)fLocation
                                  visibleType:(StatusVisibleType)visibleType
                                visibleListId:(NSNumber*)listId
                                      succeed:(StatusBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock;


//////////////评论接口
//////读取
/*!获取某条微博的评论列表，每页50条评论
 * \param weiboId 要获取评论的微博Id
 * \param page 评论页码
 * \param succeedBlock 网络请求成功处理block，array内容为Comment
 * \param errorBlock 网络请求失败处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getCommentsOfWeibo:(NSNumber*)weiboId
                                     page:(int)page
                                  succeed:(ArrayBlock)succeedBlock
                                    error:(ErrorBlock)errorBlock;

///////写入


@end
