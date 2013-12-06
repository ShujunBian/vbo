//
//  WXYDataModel.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#define STATUS_PER_PAGE 20

#import <Foundation/Foundation.h>

//Core Data
#import "Comment.h"
#import "User.h"
#import "Status.h"
#import "Group.h"
#import "AtEntity.h"
#import "LoginCachedEntity.h"


#define SHARE_DATA_MODEL [WXYDataModel shareDataModel]

@interface WXYDataModel : NSObject

+ (WXYDataModel*)shareDataModel;


//Core Data
@property (nonatomic,retain,readonly) NSManagedObjectContext* cacheManagedObjectContext;
@property (nonatomic, retain,readonly) NSManagedObjectModel* cacheManagedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* cachePersistentStoreCoordinator;
-(void)saveCacheContext;

- (void)removeAllCachedStatus;


//Base
- (Status*)getOrCreateStatusById:(long long)statusId;
- (Status*)getStatusById:(long long)statusId;
- (User*)getOrCreateUserById:(long long)userId;
- (User*)getUserById:(long long)userId;
- (User*)getOrCreateUserByScreenName:(NSString*)screenName;
- (User*)getUserByScreenName:(NSString*)screenName;
- (Comment*)getOrCreateCommentById:(long long)commentId;
- (Comment*)getCommentById:(long long)commentId;
- (Group*)getOrCreateGroupById:(long long)groupId;
- (Group*)getGroupById:(long long)groupId;

//Time line

/*
 *! 获取缓存Timeline数据
 * @param page 页码,从1开始
 * @return array内容为Status
 */
- (NSArray*)getCachedHomeTimeLineStatusOfCurrentUserPage:(int)page;
/*
 *! 将新获取到的Status和缓存中的Status合并
 * @param newStatuses 新获取的微博内容，Array内容为Status
 * @param user 用户
 * @param page 页码，从1开始
 */
- (void)mergeCachedHomeTimeLineStatusWithNewStatus:(NSArray*)newStatuses user:(User*)user page:(int)page;

//Check

/*
 *! 检测是否可将status从缓存中删除
  若status不在homeTimeLine,用户status列表,分组status列表，则可以删除
 */
- (BOOL)checkStatusDeletable:(Status*)status;


//At History

/*
 *! 获取被当前用户At次数最多count个的用户
 * @param count 用户个数
 * @return NSArray内容为User，返回个数有可能小于count
 */
- (NSArray*)getTopAtUser:(int)count;

/*
 *! 将指定用户被当前用户At的次数加一
 */
- (void)recordAtUser:(User*)user;
/*
 *! 将指定用户被当前用户At的次数加一
 * @param userId 指定用户的id
 */
- (void)recordAtUserById:(NSNumber*)userId;
/*
 *! 将指定用户被当前用户At的次数加一
 * @param screenName 指定用户的用户名
 */
- (void)recordAtUserByScreenName:(NSString*)screenName;

@end
