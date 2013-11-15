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

typedef enum{
    RepostCommentTypeNo = 0,            //不评论
    RepostCommentTypePresentStatus = 1, //评论给当前微博
    RepostCommentTypeOriginStatus = 2,  //评论给原始微博
    RepostCommentTypeAll = 3            //都评论
} RepostCommentType;                    //转发评论方式



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
/*! 转发微博
 * \param weiboId 转发原始微博的id
 * \param text 转发内容
 * \param commentType 转发评论方式
 * \param succeedBlock 网络请求成功处理block，block参数转发用的微博
 * \param errorBlock 网络请求失败处理block
 */
- (MKNetworkOperation*)repostWeibo:(NSNumber*)weiboId
                              text:(NSString*)text
                         isComment:(RepostCommentType)commentType
                           succeed:(StatusBlock)succeedBlock
                             error:(ErrorBlock)errorBlock;

/*! 删除微博
 * \param weiboId 删除微博的id
 * \param succeedBlock 网络请求成功处理block
 * \param errorBlock 网络请求失败处理block
 */
- (MKNetworkOperation*)destroyWeibo:(NSNumber*)weiboId
                            succeed:(VoidBlock)succeedBlock
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

/*!评论微博
 * \param weiboId 要评论的微博Id
 * \param content 评论内容
 * \param succeedBlock 网络请求成功处理block
 * \param errorBlock 网络请求失败处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)createCommentOfWeibo:(NSNumber*)weiboId
                                    content:(NSString*)content
                            commentOnOrigin:(BOOL)fOrigin
                                    succeed:(CommentBlock)succeedBlock
                                      error:(ErrorBlock)errorBlock;

/////////分组
///////读取
#warning 由于微博2.0获取好友分组API暂未申请完成，此接口暂无法使用
/*!读取用户分组列表
 * \param succeedBlock block参数array内容为Group
 * \param errorBlock 网络请求失败处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getGroupListSucceed:(ArrayBlock)succeedBlock
                                     error:(ErrorBlock)errorBlock;

@end
