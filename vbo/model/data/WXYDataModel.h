//
//  WXYDataModel.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

//Core Data
#import "Comment.h"
#import "User.h"
#import "Status.h"
#import "Group.h"


#define SHARE_DATA_MODEL [WXYDataModel shareDataModel]

@interface WXYDataModel : NSObject

+ (WXYDataModel*)shareDataModel;


//Core Data
@property (nonatomic,retain,readonly) NSManagedObjectContext* cacheManagedObjectContext;
@property (nonatomic, retain,readonly) NSManagedObjectModel* cacheManagedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* cachePersistentStoreCoordinator;
-(void)saveCacheContext;

- (void)removeAllCachedStatus;

- (Status*)getStatusById:(long long)statusId;
- (User*)getUserById:(long long)userId;
- (User*)getUserByScreenName:(NSString*)screenName;
- (Comment*)getCommentById:(long long)commentId;
- (Group*)getGroupById:(long long)groupId;
@end
