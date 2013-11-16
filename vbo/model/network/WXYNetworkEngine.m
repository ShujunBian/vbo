//
//  WXYNetworkEngine.m
//  vbo
//
//  Created by wxy325 on 10/22/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYNetworkEngine.h"
#import "WXYNetworkOperation.h"

#define HOST_NAME @"api.weibo.com"
#import "UIImageView+MKNetworkKitAdditions.h"

//Weibo
#define HOME_TIMELINE_URL @"2/statuses/home_timeline.json"
#define REPOST_WEIBO_URL @"2/statuses/repost.json"
#define DESTROY_WEIBO_URL @"2/statuses/destroy.json"

//post
#define POST_WEIBO_URL @"2/statuses/update.json"
#define POST_WEIBO_IMAGE_URL @"2/statuses/upload.json"

//Comment
#define COMMENT_SHOW_URL @"2/comments/show.json"
#define COMMENT_CREATE_URL @"2/comments/create.json"

//Group
#define GROUP_LIST_URL @"2/friendships/groups.json"
#define GROUP_MEMBER_URL @"2/friendships/groups/members.json"

#import "WXYSettingManager.h"
#import "WXYDataModel.h"

@interface WXYNetworkDataFactory : NSObject
+ (Status*)getStatusWithDict:(NSDictionary*)dict;
+ (Comment*)getCommentWithDict:(NSDictionary*)dict status:(Status*)s;
+ (Group*)getGroupWithDict:(NSDictionary*)dict;
+ (User*)getUserWithDict:(NSDictionary*)dict;
@end



@implementation WXYNetworkEngine

#pragma mark - Static Method
+ (WXYNetworkEngine*)shareNetworkEngine
{
    static WXYNetworkEngine* s_networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_networkEngine = [[WXYNetworkEngine alloc] initWithHostName:HOST_NAME];

        MKNetworkEngine* imageEngine = [[MKNetworkEngine alloc] init];
        [imageEngine useCache];
        [UIImageView setDefaultEngine:imageEngine];
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
                                         user:(id)user
                                     paramers:(NSDictionary*)paramDict
                                   httpMethod:(NSString*)method
                                       dataDict:(NSDictionary*)dataDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithDictionary:paramDict];
    //    if (user)
    //    {
#warning 添加用户信息
    [params setValue:SHARE_SETTING_MANAGER.testAccessToken forKey:@"access_token"];
    //    }
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
                                         user:(id)user
                                     paramers:(NSDictionary*)paramDict
                                   httpMethod:(NSString*)method
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
    return [self startOperationWithPath:path user:user paramers:paramDict httpMethod:method dataDict:nil onSucceeded:succeedBlock onError:errorBlock];
}
- (MKNetworkOperation*)startOperationWithPath:(NSString*)path
                                    needLogin:(BOOL)fLogin
                                     paramers:(NSDictionary*)paramDict
                                  onSucceeded:(OperationSucceedBlock)succeedBlock
                                      onError:(OperationErrorBlock)errorBlock
{
#warning 未完成，user暂时为nil
    return [self startOperationWithPath:path user:nil paramers:paramDict httpMethod:@"GET" onSucceeded:succeedBlock onError:errorBlock];
}

#pragma mark - Network Service Client
#pragma mark - 微博接口
#pragma mark 读取
- (MKNetworkOperation*)getHomeTimelineOfCurrentUserSucceed:(ArrayBlock)succeedBlock
                                                     error:(ErrorBlock)errorBlock
{
    MKNetworkOperation* op = nil;
    op = [self startOperationWithPath:HOME_TIMELINE_URL
                            needLogin:YES
                             paramers:@{}
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              NSArray* statuesDictArray = responseDict[@"statuses"];
              
              NSMutableArray* returnArray = [[NSMutableArray alloc] init];
              
              for (NSDictionary* dict in statuesDictArray)
              {
                  Status* status = [WXYNetworkDataFactory getStatusWithDict:dict];
                  
                  [returnArray addObject:status];
              }
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
    


    
#warning user暂为nil
    [self startOperationWithPath:urlStr user:nil paramers:paramDict httpMethod:@"POST" dataDict:imageDict onSucceeded:^(MKNetworkOperation *completedOperation) {
        NSDictionary* dict = completedOperation.responseJSON;
        Status* status = [WXYNetworkDataFactory getStatusWithDict:dict];
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
    
#warning user暂为nil
    op = [self startOperationWithPath:REPOST_WEIBO_URL
                                 user:nil
                             paramers:@{@"id":weiboId, @"status":text, @"is_comment":@(commentType)}
                           httpMethod:@"POST"
                          onSucceeded:^(MKNetworkOperation *completedOperation)
    {
        NSDictionary* dict = completedOperation.responseJSON;
        Status* status = [WXYNetworkDataFactory getStatusWithDict:dict];
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
                      status = [WXYNetworkDataFactory getStatusWithDict:dict]; //刷新微博信息
                  }
                  
                  Comment* comment = [WXYNetworkDataFactory getCommentWithDict:commentDict status:status];
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

#warning user为nil
    op = [self startOperationWithPath:COMMENT_CREATE_URL
                                 user:nil
                             paramers:@{@"id":weiboId, @"comment":content, @"comment_ori":@(fOrigin)}
                           httpMethod:@"POST"
                          onSucceeded:^(MKNetworkOperation *completedOperation)
          {
              NSDictionary* responseDict = completedOperation.responseJSON;
              Comment* comment = [WXYNetworkDataFactory getCommentWithDict:responseDict status:nil];
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
              Group* group = [SHARE_DATA_MODEL getGroupById:groupId.longLongValue];
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


@end

@implementation WXYNetworkDataFactory

+ (Status*)getStatusWithDict:(NSDictionary*)dict
{
    NSNumber* statusId = dict[@"id"];
    Status* status = [SHARE_DATA_MODEL getStatusById:statusId.longLongValue];
    [status updateWithDict:dict];
    
    NSDictionary* userDict = dict[@"user"];
    User* user = [self getUserWithDict:userDict];
    status.author = user;
#warning 多图微博处理未写   pic_urls
    NSDictionary* repostDict =  dict[@"retweeted_status"];

    //处理转发
    if (repostDict)
    {
        status.repostStatus = [self getStatusWithDict:repostDict];
    }
    return status;
}

+ (Comment*)getCommentWithDict:(NSDictionary*)dict status:(Status*)s
{
    NSNumber* commentId = dict[@"id"];
    Comment* comment = [SHARE_DATA_MODEL getCommentById:commentId.longLongValue];
    [comment updateWithDict:dict];
    
    NSDictionary* userDict = dict[@"user"];
    NSNumber* userId = userDict[@"id"];
    User* user = [SHARE_DATA_MODEL getUserById:userId.longLongValue];
    [user updateWithDict:userDict];
    comment.user = user;
    
    NSDictionary* statusDict = dict[@"status"];
    if (statusDict)
    {
        NSNumber* statusId = statusDict[@"id"];
        Status* status = [SHARE_DATA_MODEL getStatusById:statusId.longLongValue];
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
        Comment* replyComment = [WXYNetworkDataFactory getCommentWithDict:replyDict status:s];
        comment.replyComment = replyComment;
    }
    return comment;
}

+ (Group*)getGroupWithDict:(NSDictionary*)dict
{
    NSNumber* groupId = dict[@"id"];
    Group* group = [SHARE_DATA_MODEL getGroupById:groupId.longLongValue];
    [group updateWithDict:dict];

    NSDictionary* userDict = dict[@"user"];
    User* user = [self getUserWithDict:userDict];
    group.owner = user;
    return group;
}
+ (User*)getUserWithDict:(NSDictionary*)dict
{
    NSNumber* userId = dict[@"id"];
    User* user = [SHARE_DATA_MODEL getUserById:userId.longLongValue];
    [user updateWithDict:dict];
    return user;
}

@end
