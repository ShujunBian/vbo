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

#define HOME_TIMELINE_URL @"2/statuses/home_timeline.json"

#import "WXYSettingManager.h"
#import "WXYDataModel.h"

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
    [op addCompletionHandler:succeedBlock errorHandler:errorBlock];
    [self enqueueOperation:op];
    return op;
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
                  NSNumber* statusId = dict[@"id"];
                  Status* status = [SHARE_DATA_MODEL getStatusById:statusId.longLongValue];
                  [status updateWithDict:dict];
                  NSDictionary* userDict = dict[@"user"];
                  NSNumber* userId = userDict[@"id"];
                  User* user = [SHARE_DATA_MODEL getUserById:userId.longLongValue];
                  [user updateWithDict:userDict];
                  status.author = user;
                  
#warning 多图微博处理未写   pic_urls
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

@end
