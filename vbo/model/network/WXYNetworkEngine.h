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
#import "WeiboSDK.h"


#define SHARE_NW_ENGINE [WXYNetworkEngine shareNetworkEngine]

typedef enum{
    RepostCommentTypeNo = 0,            //不评论
    RepostCommentTypePresentStatus = 1, //评论给当前微博
    RepostCommentTypeOriginStatus = 2,  //评论给原始微博
    RepostCommentTypeAll = 3            //都评论
} RepostCommentType;                    //转发评论方式



@interface WXYNetworkEngine : MKNetworkEngine 

+ (WXYNetworkEngine*)shareNetworkEngine;

//////////////用户接口

/*! 用户登陆，使用微博SDK，似乎要在controller上调用
  */
- (void)userLogin;
/*! 获取用户信息
 * \param userId 所查看用户的id 与screenName二选一
 * \param screenName 所查看用户的名称  与userId二选一
 * \param succeedBlock 网络请求成功处理block
 * \param errorBlock 网络请求失败处理block
 * \returns 当前网络请求Operation
 */
- (MKNetworkOperation*)getUserInfoId:(NSNumber*)userId
                        orScreenName:(NSString*)screenName
                             succeed:(UserBlock)succeedBlock
                               error:(ErrorBlock)errorBlock;



///////////////微博接口
////////读取

/*! 获取当前登录用户及其所关注用户的最新微博
 * \param page 页码，从1开始
 * \param succeedBlock 网络请求成功处理block，block参数NSArray的内容为Status
 * \param errorBlock 网络请求失败处理block
 * \returns 当前网络请求Operation
 */
- (MKNetworkOperation*)getHomeTimelineOfCurrentUserPage:(int)page
                                                Succeed:(ArrayBlock)succeedBlock
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
 * \param page 评论页码，从1开始
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

/*!读取当前用户分组列表
 * \param succeedBlock block参数array内容为Group
 * \param errorBlock 网络请求失败处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getGroupListSucceed:(ArrayBlock)succeedBlock
                                     error:(ErrorBlock)errorBlock;

/*!读取分组用户列表
 * \param groupId 分组id
 * \param cursor 页码游标，默认为0
 * \param succeedBlock group为当前获取的分组, previousCursor与 nextCursor为上、下页游标，用于下次请求
 * \param errorBlock 错误处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getGroupMemberListById:(NSNumber*)groupId
                                       cursor:(NSNumber*)cursor
                                      succeed:(GroupWithCursorBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock;
/*!读取分组微博列表
 * \param groupId 分组id
 * \param page 页码,从1开始
 * \param SucceedBlock 成功处理block,array内容为Status
 * \param errorBlock 错误处理block
 */
- (MKNetworkOperation*)getGroupStatusListById:(NSNumber*)groupId
                                         page:(int)page
                                      succeed:(ArrayBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock;
//写入

////////关系接口
//////读取

/*!读取用户关注列表(一次最多200条)
 * \param userId 用户Id，与screenName二选一
 * \param screenName 用户名称，与userId二选一
 * \param count 返回数量，最多200
 * \param cursor 页码游标，默认为0
 * \param succeedBlock Array内容为User, previousCursor与 nextCursor为上、下页游标，用于下次请求，没有则为0
 * \param errorBlock 错误处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getFriendListById:(NSNumber*)userId
                              screenName:(NSString*)screenName
                                   count:(int)count
                                  cursor:(NSNumber*)cursor
                                 succeed:(ArrayWithCursorBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock;
- (MKNetworkOperation*)getFirstFriendListById:(NSNumber*)userId
                                      succeed:(ArrayBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock;
/*!读取用户关注的所有用户
 * \param userId 用户Id，与screenName二选一
 * \param screenName 用户名称，与userId二选一
 * \param succeedBlock Array内容为User
 * \param errorBlock 错误处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getAllFriendListById:(NSNumber*)userId
                                 screenName:(NSString*)screenName
                                    succeed:(ArrayBlock)succeedBlock
                                      error:(ErrorBlock)errorBlock;
/*!读取当前用户关注的所有用户
 * \param succeedBlock Array内容为User
 * \param errorBlock 错误处理block
 * \return 当前网络请求Operation
 */
- (MKNetworkOperation*)getAllFriendOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                  error:(ErrorBlock)errorBlock;


/////发现
//读取

/*!获取当前热门微博
 * @param page 页码，从1开始
 * @param succeedBlock 成功处理block,Array内容为Status
 */
- (MKNetworkOperation*)getHotWeiboPage:(int)page
                               succeed:(ArrayBlock)succeedBlock
                                 error:(ErrorBlock)errorBlock;

/*!获取热门用户
 * @param succeedBlock 成功处理block,Array内容为User
 */
- (MKNetworkOperation*)getHotUserSucceed:(ArrayBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock;

/*!获取一小时内热门话题
 * @param succeedBlock 成功处理block,Array内容为NSString
 */
- (MKNetworkOperation*)getHotTopicSucceed:(ArrayBlock)succeedBlock
                                    error:(ErrorBlock)errorBlock;

/*!搜索某一话题下的微博
 * @param keyword 关键字
 * @param page 页码，从1开始
 * @param succeedBlock 成功处理block,Array内容为Status
 */
- (MKNetworkOperation*)searchTopic:(NSString*)keyword
                              page:(int)page
                           succeed:(ArrayBlock)succeedBlock
                             error:(ErrorBlock)errorBlock;


////收藏
//读取

/*!读取当前用户收藏列表
 * @param page 页码，从1开始
 * @param succeedBlock 成功处理block,Array内容为Status
 */
- (MKNetworkOperation*)getFavoriteStatusPage:(int)page
                                     succeed:(ArrayBlock)succeedBlock
                                       error:(ErrorBlock)errorBlock;

//写入



- (MKNetworkOperation*)getTimelineOfUser:(User*)user
                                    page:(int)page
                                 succeed:(ArrayBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock;
@end
