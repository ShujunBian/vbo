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

//
#define HOME_TIMELINE_URL @"2/statuses/home_timeline.json"

//post
#define POST_WEIBO_URL @"2/statuses/update.json"
#define POST_WEIBO_IMAGE_URL @"2/statuses/upload.json"

#import "WXYSettingManager.h"
#import "WXYDataModel.h"

@interface WXYNetworkDataFactory : NSObject
+ (Status*)getStatusWithDict:(NSDictionary*)dict;
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


@end

@implementation WXYNetworkDataFactory

+ (Status*)getStatusWithDict:(NSDictionary*)dict
{
    NSNumber* statusId = dict[@"id"];
    Status* status = [SHARE_DATA_MODEL getStatusById:statusId.longLongValue];
    [status updateWithDict:dict];
    NSDictionary* userDict = dict[@"user"];
    NSNumber* userId = userDict[@"id"];
    User* user = [SHARE_DATA_MODEL getUserById:userId.longLongValue];
    [user updateWithDict:userDict];
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

@end
