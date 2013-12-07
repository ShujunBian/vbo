//
//  WXYNetworkEngine.m
//  vbo
//
//  Created by wxy325 on 10/22/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYNetworkEngine.h"
#import "WXYNetworkOperation.h"
#import "NSArray+ConvertToOrderedSet.h"

#define HOST_NAME @"api.weibo.com"
#import "UIImageView+MKNetworkKitAdditions.h"

//User
#define USER_SHOW_URL @"2/users/show.json"

//Weibo
#define HOME_TIMELINE_URL @"2/statuses/home_timeline.json"
#define REPOST_WEIBO_URL @"2/statuses/repost.json"
#define DESTROY_WEIBO_URL @"2/statuses/destroy.json"
#define USER_TIMELINE_URL @"2/statuses/user_timeline.json"

//post
#define POST_WEIBO_URL @"2/statuses/update.json"
#define POST_WEIBO_IMAGE_URL @"2/statuses/upload.json"

//Comment
#define COMMENT_SHOW_URL @"2/comments/show.json"
#define COMMENT_CREATE_URL @"2/comments/create.json"

//Group
#define GROUP_LIST_URL @"2/friendships/groups.json"
#define GROUP_MEMBER_URL @"2/friendships/groups/members.json"
#define GROUP_STATUS_URL @"2/friendships/groups/timeline.json"

//Relation
#define RELATION_FRIEND_LIST_URL @"2/friendships/friends.json"
#define FRIEND_SHIP_CREATE @"2/friendships/create.json"
#define FROIEND_SHIP_DESTORY @"2/friendships/destroy.json"

//Discover
#define DISCOVER_HOT_WEIBO_URL @"2/suggestions/favorites/hot.json"
#define DISCOVER_HOT_USER_URL @"2/suggestions/users/hot.json"
#define DISCOVER_TOPIC_HOURLY @"2/trends/hourly.json"
#define DISCOVER_TOPIC_DAILY @"2/trends/daily.json"
#define DISCOVER_TOPIC_WEEKLY @"2/trends/weekly.json"
#define DISCOVER_SEARCH_TOPIC @"2/search/topics.json"

//Favorite
#define FAVOR_GET_LIST_URL @"2/favorites.json"


#import "WXYSettingManager.h"
#import "WXYDataModel.h"
#import "WXYLoginManager.h"


@interface WXYNetworkDataFactory : NSObject
+ (Status*)getStatusWithDictIncludeUser:(NSDictionary*)dict;
+ (Status*)getStatusWithDict:(NSDictionary*)dict;
+ (Comment*)getCommentIncludeUserWithDict:(NSDictionary*)dict status:(Status*)s;
+ (Group*)getGroupWithDict:(NSDictionary*)dict;
+ (User*)getUserWithDict:(NSDictionary*)dict;
+ (User*)getUserWithDictIncludeStatus:(NSDictionary*)dict;
@end


@interface WXYNetworkEngine ()
- (MKNetworkOperation*)recursiveHelpGetAllFriendById:(NSNumber*)userId
                                          screenName:(NSString*)screenName
                                              cursor:(NSNumber*)cursor
                                         returnArray:(NSMutableArray*)returnArray
                                             succeed:(ArrayBlock)succeedBlock
                                               error:(ErrorBlock)errorBlock;

@end


@implementation WXYNetworkEngine

#pragma mark - Static Method
+ (WXYNetworkEngine*)shareNetworkEngine
{
    static WXYNetworkEngine* s_networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_networkEngine = [[WXYNetworkEngine alloc] initWithHostName:HOST_NAME];
    });
    return s_networkEngine;
}

#pragma mark - Init Method
- (id)initWithHostName:(NSString *)hostName
{
    self = [super initWithHostName:hostName];
    if (self)
    {
        [self registerOperationSubclass:[WXYNetworkOperation class]];
    }
    return self;
}
#pragma mark - Private Method
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                         user:(LoginUserInfo*)userInfo
                                     paramers:(NSDictionary*)paramDict
                                   httpMethod:(NSString*)method
                                       dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    if (userInfo)
    {
        [params setValue:userInfo.accessToken forKey:@"access_token"];
    }
    [params addEntriesFromDictionary:paramDict];
    op = [self operationWithPath:path
                          params:params
                      httpMethod:method
                             ssl:YES];
    for (NSString* key in dataDict.allKeys)
    {
        [op addData:dataDict[key] forKey:key];
    }

    [op addCompletionHandler:succeedBlock errorHandler:errorBlock];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                         user:(LoginUserInfo*)userInfo
                                     paramers:(NSDictionary*)paramDict
                                   httpMethod:(NSString*)method
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    return [self startOperationWithPath:path user:userInfo paramers:paramDict httpMethod:method dataDict:nil onSucceeded:succeedBlock onError:errorBlock];
}
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    LoginUserInfo* userInfo = nil;
    if (fLogin)
    {
        userInfo = SHARE_LOGIN_MANAGER.currentUserInfo;
    }
    return [self startOperationWithPath:path user:userInfo paramers:paramDict httpMethod:@"GET" onSucceeded:succeedBlock onError:errorBlock];
}

#pragma mark - Network Service Client
#pragma mark - 用户接口
#pragma mark 用户登陆
- (void)userLogin
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WEIBO_REDIRECT_URI;
    request.scope = @"all";
    
    [WeiboSDK sendRequest:request];
}
#pragma mark 获取用户信息
- (MKNetworkOperation*)getUserInfoId:(NSNumber*)userId
                        orScreenName:(NSString*)screenName
                             succeed:(UserBlock)succeedBlock
                               error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    NSMutableDictionary* paramDict = [[NSMutableDictionary alloc] init];
    if (userId)
    {
        [paramDict setValue:userId forKey:@"uid"];
    }
    else
    {
        [paramDict setValue:screenName forKey:@"screen_name"];
    }
    
    op = [self startOperationWithPath:USER_SHOW_URL
                            needLogin:YES
                             paramers:paramDict
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              User* user = [WXYNetworkDataFactory getUserWithDictIncludeStatus:responseDict];
              [SHARE_DATA_MODEL saveCacheContext];
              if (succeedBlock)
              {
                  succeedBlock(user);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

#pragma mark - 微博接口
#pragma mark 读取
- (MKNetworkOperation*)getHomeTimelineOfCurrentUserPage:(int)page
                                                Succeed:(ArrayBlock)succeedBlock
                                                  error:(ErrorBlock)errorBlock;
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:HOME_TIMELINE_URL
                            needLogin:YES
                             paramers:@{@"page":@(page),
                                        @"count":@(STATUS_PER_PAGE)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSArray* statuesDictArray = responseDict[@"statuses"];
              
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              
              
              User* user = SHARE_LOGIN_MANAGER.currentUser;
              
              for (NSDictionary* dict in statuesDictArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  
                  [returnArray addObject:status];
              }
              
              [SHARE_DATA_MODEL mergeCachedHomeTimeLineStatusWithNewStatus:returnArray user:user page:page];
              
              [SHARE_DATA_MODEL saveCacheContext];
              succeedBlock(returnArray);
              
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
    
}

#pragma mark 写入
- (MKNetworkOperation*)postWeiboOfCurrentUser:(NSString*)content
                                        image:(UIImage*)weiboImage
                                 withLocation:(BOOL)fLocation
                                  visibleType:(StatusVisibleType)visibleType
                                visibleListId:(NSNumber*)listId
                                      succeed:(StatusBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    NSString *urlStr = nil;
    NSMutableDictionary* paramDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"status":content, @"visible":@(visibleType)}];
    if (visibleType == StatusVisibleTypeGroup)
    {
        [paramDict setValue:listId forKey:@"list_id"];
    }
    //annotations
    NSDictionary* imageDict = nil;
    if (weiboImage)
    {
        urlStr = POST_WEIBO_IMAGE_URL;
        
#warning 图片压缩未处理
        NSData *imageData = UIImageJPEGRepresentation(weiboImage, 0.5);
        imageDict = @{@"pic":imageData};
    }
    else
    {
        urlStr = POST_WEIBO_URL;
    }
    

    [self startOperationWithPath:urlStr user:SHARE_LOGIN_MANAGER.currentUserInfo paramers:paramDict httpMethod:@"POST" dataDict:imageDict onSucceeded:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = completedOperation.responseJSON;
        Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
        [SHARE_DATA_MODEL saveCacheContext];
        if (succeedBlock)
        {
            succeedBlock(status);
        }
    } onError:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    
    return op;
}

- (MKNetworkOperation*)repostWeibo:(NSNumber*)weiboId
                              text:(NSString*)text
                         isComment:(RepostCommentType)commentType
                           succeed:(StatusBlock)succeedBlock
                             error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:REPOST_WEIBO_URL
                                 user:SHARE_LOGIN_MANAGER.currentUserInfo
                             paramers:@{@"id":weiboId, @"status":text, @"is_comment":@(commentType)}
                           httpMethod:@"POST"
                          onSucceeded:^(MKNetworkOperation *completedOperation)
    {
        NSDictionary* dict = completedOperation.responseJSON;
        Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
        [SHARE_DATA_MODEL saveCacheContext];
        if (succeedBlock)
        {
            succeedBlock(status);
        }
    }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
    {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];    
    return op;
}

#warning 未测试
- (MKNetworkOperation*)destroyWeibo:(NSNumber*)weiboId
                            succeed:(VoidBlock)succeedBlock
                              error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:DESTROY_WEIBO_URL
                                 user:nil
                             paramers:@{@"id":weiboId}
                           httpMethod:@"POST"
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
#warning 缓存删除未处理
              if (succeedBlock)
              {
                  succeedBlock();
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}

#pragma mark - 评论接口
#pragma mark 读取
- (MKNetworkOperation*)getCommentsOfWeibo:(NSNumber*)weiboId
                                     page:(int)page
                                  succeed:(ArrayBlock)succeedBlock
                                    error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:COMMENT_SHOW_URL
                            needLogin:YES
                             paramers:@{@"id":weiboId, @"page":@(page)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* dict = completedOperation.responseJSON;
              NSDictionary* commentArray = dict[@"comments"];
              
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              
              BOOL fFirst = YES;
              Status* status = nil;

              for (NSDictionary* commentDict in commentArray)
              {
                  if (fFirst)
                  {
                      fFirst = NO;
                      NSDictionary* dict = commentDict[@"status"];
                      NSNumber* weiboId = dict[@"id"];
                      status = [SHARE_DATA_MODEL getOrCreateStatusById:weiboId.longLongValue];
#warning 微博API bug,此处commentCount与repostCount永远返回0
//                      status = [WXYNetworkDataFactory getStatusWithDict:dict]; //刷新微博信息
                  }
                  
                  Comment* comment = [WXYNetworkDataFactory getCommentIncludeUserWithDict:commentDict status:status];
                  [returnArray addObject:comment];
              }
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
              [SHARE_DATA_MODEL saveCacheContext];
              
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock) {
                  errorBlock(error);
              }
          }];
    return op;
}


#pragma mark 写入
- (MKNetworkOperation*)createCommentOfWeibo:(NSNumber*)weiboId
                                    content:(NSString*)content
                            commentOnOrigin:(BOOL)fOrigin
                                    succeed:(CommentBlock)succeedBlock
                                      error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;

    op = [self startOperationWithPath:COMMENT_CREATE_URL
                                 user:SHARE_LOGIN_MANAGER.currentUserInfo
                             paramers:@{@"id":weiboId, @"comment":content, @"comment_ori":@(fOrigin)}
                           httpMethod:@"POST"
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              Comment* comment = [WXYNetworkDataFactory getCommentIncludeUserWithDict:responseDict status:nil];
              [SHARE_DATA_MODEL saveCacheContext];
              if (succeedBlock)
              {
                  succeedBlock(comment);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}

#pragma mark - 分组
#pragma mark 读取
- (MKNetworkOperation*)getGroupListSucceed:(ArrayBlock)succeedBlock
                                     error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:GROUP_LIST_URL
                            needLogin:YES
                             paramers:@{}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              
              NSArray* groupDictArray = responseDict[@"lists"];
              
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              for (NSDictionary* dict in groupDictArray)
              {
                  Group* group = [WXYNetworkDataFactory getGroupWithDict:dict];
#warning user暂不知user参数未什么情况
                  [returnArray addObject:group];
              }
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
              
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}
- (MKNetworkOperation*)getGroupMemberListById:(NSNumber*)groupId
                                       cursor:(NSNumber*)cursor
                                      succeed:(GroupWithCursorBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:GROUP_MEMBER_URL
                            needLogin:YES
                             paramers:@{@"list_id":groupId, @"cursor":cursor}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSNumber* previousCursor = responseDict[@"previous_cursor"];
              NSNumber* nextCursor = responseDict[@"next_cursor"];
              
              NSArray* userDictArray = responseDict[@"users"];
              Group* group = [SHARE_DATA_MODEL getOrCreateGroupById:groupId.longLongValue];
              for (NSDictionary* userDict in userDictArray)
              {
                  User* user = [WXYNetworkDataFactory getUserWithDict:userDict];
                  [group addUsersObject:user];
              }
              if (succeedBlock)
              {
                  succeedBlock(group, previousCursor, nextCursor);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)getGroupStatusListById:(NSNumber*)groupId
                                         page:(int)page
                                      succeed:(ArrayBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:GROUP_STATUS_URL
                            needLogin:YES
                             paramers:@{@"list_id":groupId, @"page":@(page)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSArray* statusesArray = responseDict[@"statuses"];
              Group* group = [SHARE_DATA_MODEL getOrCreateGroupById:groupId.longLongValue];
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              for (NSDictionary* dict in statusesArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  [returnArray addObject:status];
                  [group addStatusesObject:status];
              }
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}


#pragma mark - Relation
#pragma mark Read
- (MKNetworkOperation*)getFriendListById:(NSNumber*)userId
                              screenName:(NSString*)screenName
                                   count:(int)count
                                  cursor:(NSNumber*)cursor
                                 succeed:(ArrayWithCursorBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock
{
#warning 未测试
    MKNetworkOperation* op = nil;
    NSMutableDictionary* paramDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"count": @(count), @"cursor":cursor}];
    
    User* mainUser = nil;
    
    if (userId)
    {
        [paramDict setValue:userId forKey:@"uid"];
        mainUser = [SHARE_DATA_MODEL getOrCreateUserById:userId.longLongValue];
    }
    else
    {
        [paramDict setValue:screenName forKey:@"screen_name"];
        mainUser = [SHARE_DATA_MODEL getOrCreateUserByScreenName:screenName];
    }
    
    op = [self startOperationWithPath:RELATION_FRIEND_LIST_URL
                            needLogin:YES
                             paramers:paramDict
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSNumber* nextCursor = responseDict[@"next_cursor"];
              NSNumber* previewCursor = responseDict[@"previous_cursor"];
              NSArray* userDictArray = responseDict[@"users"];
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              for (NSDictionary* dict in userDictArray)
              {
                  User* u = [WXYNetworkDataFactory getUserWithDict:dict];
                  [returnArray addObject:u];
                  [mainUser addFollowingUsersObject:u];
              }
              [SHARE_DATA_MODEL saveCacheContext];
              if (succeedBlock)
              {
                  succeedBlock(returnArray,previewCursor,nextCursor);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    
    return op;
}


//递归获取所有用户辅助方法
- (MKNetworkOperation*)recursiveHelpGetAllFriendById:(NSNumber*)userId
                                          screenName:(NSString*)screenName
                                              cursor:(NSNumber*)cursor
                                         returnArray:(NSMutableArray*)returnArray
                                             succeed:(ArrayBlock)succeedBlock
                                               error:(ErrorBlock)errorBlock
{
    __block MKNetworkOperation* op = nil;

    op = [self getFriendListById:userId
                 screenName:screenName
                      count:200
                     cursor:cursor
                    succeed:^(NSArray *array, NSNumber *previousCursor, NSNumber *nextCursor)
    {
        [returnArray addObjectsFromArray:array];
        
        if (nextCursor.longLongValue == 0)
        {
            //递归结束
            if (succeedBlock)
            {
                succeedBlock(returnArray);
            }
        }
        else
        {
            //继续递归
            op = [self recursiveHelpGetAllFriendById:userId
                                     screenName:screenName
                                         cursor:nextCursor
                                    returnArray:returnArray
                                        succeed:succeedBlock
                                          error:errorBlock];
        }
        
    }
                      error:^(NSError *error)
    {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    return op;
}
- (MKNetworkOperation*)getAllFriendListById:(NSNumber*)userId
                                 screenName:(NSString*)screenName
                                    succeed:(ArrayBlock)succeedBlock
                                      error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableArray* returnArray = [[NSMutableArray alloc] init];
    op = [self recursiveHelpGetAllFriendById:userId screenName:screenName cursor:@(0) returnArray:returnArray succeed:succeedBlock error:errorBlock];
    return op;
}
- (MKNetworkOperation*)getAllFriendOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                  error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    LoginUserInfo* info = SHARE_LOGIN_MANAGER.currentUserInfo;
    if (info)
    {
        op = [self getAllFriendListById:@(info.userId.longLongValue)
                             screenName:nil
                                succeed:succeedBlock
                                  error:errorBlock];
    }
    return op;
}



#pragma mark - 发现
#pragma mark 读取
- (MKNetworkOperation*)getHotWeiboPage:(int)page
                               succeed:(ArrayBlock)succeedBlock
                                 error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:DISCOVER_HOT_WEIBO_URL
                            needLogin:YES
                             paramers:@{@"page":@(page), @"count":@(STATUS_PER_PAGE)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSArray* responseArray = completedOperation.responseJSON;
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              for (NSDictionary* dict in responseArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  [returnArray addObject:status];
              }
#warning 未添加缓存
//              [SHARE_LOGIN_MANAGER.currentUser.loginCached addHotStatuses:[returnArray convertToOrderedSet]];
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)getHotUserSucceed:(ArrayBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:DISCOVER_HOT_USER_URL
                            needLogin:YES
                             paramers:@{}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSArray* responseArray = completedOperation.responseJSON;
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              for (NSDictionary* dict in responseArray)
              {
                  User* user = [WXYNetworkDataFactory getUserWithDictIncludeStatus:dict];
                  [returnArray addObject:user];
              }
#warning 未加入缓存
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    
    return op;
}

- (MKNetworkOperation*)getHotTopicSucceed:(ArrayBlock)succeedBlock
                                    error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    
    op = [self startOperationWithPath:DISCOVER_TOPIC_DAILY
                            needLogin:YES
                             paramers:@{}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
    {
        NSMutableArray* returnArray = [[NSMutableArray alloc] init];
        NSDictionary* responseDict = completedOperation.responseJSON;
        NSDictionary* topicsDict = responseDict[@"trends"];
        NSArray* arrayArray = [topicsDict allValues];
        for (NSArray* a in arrayArray)
        {
            for (NSDictionary* topicDict in a)
            {
                [returnArray addObject:topicDict[@"name"]];
            }
        }
        if (succeedBlock)
        {
            succeedBlock(returnArray);
        }
    }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
    {
        if (errorBlock)
        {
            errorBlock(error);
        }
    }];
    
    return op;
}

- (MKNetworkOperation*)searchTopic:(NSString*)keyword
                              page:(int)page
                           succeed:(ArrayBlock)succeedBlock
                             error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:DISCOVER_SEARCH_TOPIC
                            needLogin:YES
                             paramers:@{@"q":keyword, @"page":@(page),@"count":@(STATUS_PER_PAGE)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* dict = completedOperation.responseJSON;
              NSArray* statusDictArray = dict[@"statuses"];
              NSMutableArray* returnArray = [@[] mutableCopy];
              for (NSDictionary* dict in statusDictArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  [returnArray addObject:status];
              }
#warning 缓存垃圾未处理
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}

#pragma mark - 收藏
#pragma mark 读取
- (MKNetworkOperation*)getFavoriteStatusPage:(int)page
                                     succeed:(ArrayBlock)succeedBlock
                                       error:(ErrorBlock)errorBlock
{
#warning 标签未处理
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:FAVOR_GET_LIST_URL
                            needLogin:YES
                             paramers:@{@"page":@(page), @"count":@(STATUS_PER_PAGE)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSMutableArray* returnArray = [@[] mutableCopy];
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSArray* favoriteArray = responseDict[@"favorites"];
              for (NSDictionary* favorDict in favoriteArray)
              {
                  NSDictionary* dict = favorDict[@"status"];
                  Status* s = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  [returnArray addObject:s];
              }
#warning 缓存未处理
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}



- (MKNetworkOperation*)getTimelineOfUser:(User*)user
                                    page:(int)page
                                 succeed:(ArrayBlock)succeedBlock
                                   error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:USER_TIMELINE_URL
                            needLogin:YES
                             paramers:@{@"uid":user.userID,@"page":@(page)}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          
          {
              NSDictionary* dict = completedOperation.responseJSON;
              NSArray* statusArray = dict[@"statuses"];
              NSMutableArray* returnArray = [@[] mutableCopy];
              for (NSDictionary* dict in statusArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDictIncludeUser:dict];
                  [returnArray addObject:status];
              }
              if (succeedBlock)
              {
                  succeedBlock(returnArray);
              }
          }
                              onError:^(MKNetworkOperation *completedOperation, NSError *error)
          {
              if (errorBlock)
              {
                  errorBlock(error);
              }
          }];
    return op;
}

- (MKNetworkOperation*)getFirstFriendListById:(NSNumber*)userId
                                      succeed:(ArrayBlock)succeedBlock
                                        error:(ErrorBlock)errorBlock
{
    return [self getFriendListById:userId screenName:nil count:20 cursor:@(0) succeed:^(NSArray *array, NSNumber *previousCursor, NSNumber *nextCursor) {
        succeedBlock(array);
    } error:errorBlock];
}
@end

@implementation WXYNetworkDataFactory
+ (Status*)getStatusWithDict:(NSDictionary*)dict
{
    NSNumber* statusId = dict[@"id"];
    Status* status = [SHARE_DATA_MODEL getOrCreateStatusById:statusId.longLongValue];
    [status updateWithDict:dict];
    return status;
}
+ (Status*)getStatusWithDictIncludeUser:(NSDictionary*)dict
{
    Status* status = [self getStatusWithDict:dict];
    
    NSDictionary* userDict = dict[@"user"];
    User* user = [self getUserWithDict:userDict];
    status.author = user;
#warning 多图微博处理未写   pic_urls
    NSDictionary* repostDict =  dict[@"retweeted_status"];

    //处理转发
    if (repostDict)
    {
        status.repostStatus = [self getStatusWithDictIncludeUser:repostDict];
    }
    return status;
}

+ (Comment*)getCommentIncludeUserWithDict:(NSDictionary*)dict status:(Status*)s
{
    NSNumber* commentId = dict[@"id"];
    Comment* comment = [SHARE_DATA_MODEL getOrCreateCommentById:commentId.longLongValue];
    [comment updateWithDict:dict];
    
    NSDictionary* userDict = dict[@"user"];
    NSNumber* userId = userDict[@"id"];
    User* user = [SHARE_DATA_MODEL getOrCreateUserById:userId.longLongValue];
    [user updateWithDict:userDict];
    comment.user = user;
    
    NSDictionary* statusDict = dict[@"status"];
    if (statusDict)
    {
        NSNumber* statusId = statusDict[@"id"];
        Status* status = [SHARE_DATA_MODEL getOrCreateStatusById:statusId.longLongValue];
        if (status.text && status.createdAt)
        {
            s = status;
        }
    }
    comment.status = s;
    
    NSDictionary* replyDict = dict[@"reply_comment"];
    if (replyDict)
    {
        //回复的微博中，没有"Status"属性
        Comment* replyComment = [WXYNetworkDataFactory getCommentIncludeUserWithDict:replyDict status:s];
        comment.replyComment = replyComment;
    }
    return comment;
}

+ (Group*)getGroupWithDict:(NSDictionary*)dict
{
    NSNumber* groupId = dict[@"id"];
    Group* group = [SHARE_DATA_MODEL getOrCreateGroupById:groupId.longLongValue];
    [group updateWithDict:dict];

    NSDictionary* userDict = dict[@"user"];
    User* user = [self getUserWithDict:userDict];
    group.owner = user;
    return group;
}

+ (User*)getUserWithDict:(NSDictionary*)dict
{
    NSNumber* userId = dict[@"id"];
    User* user = [SHARE_DATA_MODEL getOrCreateUserById:userId.longLongValue];
    [user updateWithDict:dict];

    return user;
}
+ (User*)getUserWithDictIncludeStatus:(NSDictionary*)dict
{
    User* user = [self getUserWithDict:dict];
    NSDictionary* statusDict = dict[@"status"];
    Status* status = [self getStatusWithDict:statusDict];
    [user addStatusesObject:status];
    return user;
}


@end
