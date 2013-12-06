//
//  WXYDataModel.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//



#import "WXYDataModel.h"
#import "WXYLoginManager.h"
#import "NSArray+ConvertToOrderedSet.h"
#import <CoreData/CoreData.h>

@interface WXYDataModel ()

//DocumentsDirectory
-(NSURL*)applicationDocumentsDirectory;
-(NSURL*)applicationCachesDirectory;
-(NSString*)applicationDocumentsDirectoryPath;
-(NSString*)applicationCachesDirectoryPath;

@end

@implementation WXYDataModel

@synthesize cacheManagedObjectContext = _cacheManagedObjectContext;
@synthesize cacheManagedObjectModel = _cacheManagedObjectModel;
@synthesize cachePersistentStoreCoordinator = _cachePersistentStoreCoordinator;

#pragma mark - Static Method
#pragma mark Singleton
+ (WXYDataModel*)shareDataModel
{
    static WXYDataModel* s_dataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dataModel = [[WXYDataModel alloc] init];
    });
    return s_dataModel;
}


#pragma mark - Core Data
#pragma mark Cache
-(NSManagedObjectContext*)cacheManagedObjectContext
{
    if (_cacheManagedObjectContext != nil)
    {
        return _cacheManagedObjectContext;
    }
    NSPersistentStoreCoordinator* coordinator = [self cachePersistentStoreCoordinator];
    if (coordinator != nil)
    {
        _cacheManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [_cacheManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _cacheManagedObjectContext;
}
-(NSManagedObjectModel*)cacheManagedObjectModel
{
    if (_cacheManagedObjectModel != nil)
    {
        return _cacheManagedObjectModel;
    }
    NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"vboCachedDatamodel" withExtension:@"momd"];
    _cacheManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _cacheManagedObjectModel;
}
-(NSPersistentStoreCoordinator*)cachePersistentStoreCoordinator
{
    if (_cachePersistentStoreCoordinator != nil)
    {
        return _cachePersistentStoreCoordinator;
    }
    NSURL* storeURL = [[self applicationCachesDirectory] URLByAppendingPathComponent:@"vboCache.sqlite"];
    NSError* error = nil;
    _cachePersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self cacheManagedObjectModel]];
    if (![_cachePersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"%@,%@",error,[error userInfo]);
    }
    return _cachePersistentStoreCoordinator;
}
-(void)saveCacheContext
{
    NSError* error = nil;
    NSManagedObjectContext* managedObjectContext = self.cacheManagedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"%@,%@",error,[error userInfo]);
            abort();
        }
    }
}
#pragma mark - App Documents Directory
-(NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
-(NSURL*)applicationCachesDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}
-(NSString*)applicationDocumentsDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
-(NSString*)applicationCachesDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
- (void)removeAllCachedStatus
{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Status"];
    NSArray* resultArray = [self.cacheManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject* obj in resultArray)
    {
        [self.cacheManagedObjectContext deleteObject:obj];
    }
    [self saveCacheContext];
}

#pragma mark - Base
- (id)getEntity:(NSString*)entityName byId:(long long)entityId idPropertyName:(NSString*)propertyName
{
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSString* predicateStr = [NSString stringWithFormat:@"%@==%lld",propertyName,entityId];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateStr];
    fetchRequest.predicate = predicate;
    
//    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%@=%lld",propertyName,entityId];
//    [fetchRequest setPredicate:predicate];
    NSArray* resultArray = [self.cacheManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    id returnEntity = nil;
    if (resultArray.count)
    {
        returnEntity = resultArray[0];
    }
//    else
//    {
//        returnStatus = [Status insertWithId:@(statusId) InContext:self.cacheManagedObjectContext];
//    }
    return returnEntity;
}

- (Status*)getOrCreateStatusById:(long long)statusId
{
    Status* returnStatus = [self getStatusById:statusId];
    
    if (!returnStatus)
    {
        returnStatus = [Status insertWithId:@(statusId) InContext:self.cacheManagedObjectContext];
    }
    return returnStatus;
}
- (Status*)getStatusById:(long long)statusId
{
    Status* returnStatus = nil;
    returnStatus = [self getEntity:@"Status" byId:statusId idPropertyName:@"statusID"];
    return returnStatus;
}
- (User*)getOrCreateUserByScreenName:(NSString*)screenName
{
    User* user = [self getUserByScreenName:screenName];
    if (!user)
    {
        user = [User insertWithId:@(-1) InContext:SHARE_DATA_MODEL.cacheManagedObjectContext];
        user.screenName = screenName;
    }
    return user;
}
- (User*)getUserByScreenName:(NSString*)screenName
{
    User* user = nil;
    
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"screenName==%@",screenName];
    [fetchRequest setPredicate:predicate];
    NSArray* resultArray = [SHARE_DATA_MODEL.cacheManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    if (resultArray.count)
    {
        user = resultArray[0];
    }
    return user;
}

- (User*)getOrCreateUserById:(long long)userId
{
    User* returnUser = [self getUserById:userId];
    if (!returnUser)
    {
        returnUser = [User insertWithId:@(userId) InContext:self.cacheManagedObjectContext];
    }
    return returnUser;
}
- (User*)getUserById:(long long)userId
{
    User* returnUser = nil;
    returnUser = [self getEntity:@"User" byId:userId idPropertyName:@"userID"];
    return returnUser;
}
- (Comment*)getOrCreateCommentById:(long long)commentId
{
    Comment* returnComment = [self getCommentById:commentId];
    if (!returnComment)
    {
        returnComment = [Comment insertWithId:@(commentId) InContext:self.cacheManagedObjectContext];
    }
    return returnComment;
}
- (Comment*)getCommentById:(long long)commentId
{
    Comment* returnComment = nil;
    returnComment = [self getEntity:@"Comment" byId:commentId idPropertyName:@"commentID"];
    return returnComment;
}
- (Group*)getOrCreateGroupById:(long long)groupId
{
    Group* returnGroup = [self getGroupById:groupId];
    if (!returnGroup)
    {
        returnGroup = [Group insertWithId:@(groupId) inContext:self.cacheManagedObjectContext];
    }
    return returnGroup;
}
- (Group*)getGroupById:(long long)groupId
{
    Group* returnGroup = nil;
    returnGroup = [self getEntity:@"Group" byId:groupId idPropertyName:@"groupId"];
    return returnGroup;
}

#pragma mark - Time Line
- (NSArray*)getCachedHomeTimeLineStatusOfCurrentUserPage:(int)page
{
    User* user = SHARE_LOGIN_MANAGER.currentUser;
    NSArray* timeLineArray = user.loginCached.homeTimeLine.array;
    NSArray* returnArray = nil;

    int fromIndex = (page - 1) * STATUS_PER_PAGE;
    int toIndex = page * STATUS_PER_PAGE;
    if (timeLineArray.count > fromIndex)
    {
        toIndex = timeLineArray.count < toIndex ? timeLineArray.count : toIndex;
        returnArray = [timeLineArray subarrayWithRange:NSMakeRange(fromIndex, toIndex - fromIndex)];
    }
    return returnArray;
}

- (void)mergeCachedHomeTimeLineStatusWithNewStatus:(NSArray*)newStatuses user:(User*)user page:(int)page
{
    LoginCachedEntity* cachedList = user.loginCached;
    int fromIndex = (page - 1) * STATUS_PER_PAGE;
    NSArray* removeArray = [cachedList.homeTimeLine.array subarrayWithRange:NSMakeRange(fromIndex, cachedList.homeTimeLine.count - fromIndex)];
    [cachedList removeHomeTimeLine:[removeArray convertToOrderedSet]];
    [cachedList addHomeTimeLine:[newStatuses convertToOrderedSet] ];

    for (Status* s in removeArray)
    {
        if ([self checkStatusDeletable:s])
        {
            [self.cacheManagedObjectContext deleteObject:s];
#warning 未处理删除User
        }
    }
    [self saveCacheContext];
}

#pragma mark - Check
- (BOOL)checkStatusDeletable:(Status*)status
{
    return !status.beInTimeline.count && !status.beInStatusList.count && !status.groups.count;
}

#pragma mark - At History
- (NSArray*)getTopAtUser:(int)count
{
    NSMutableArray* returnArray = [@[] mutableCopy];
    LoginCachedEntity* u = SHARE_LOGIN_MANAGER.currentUser.loginCached;
    
    count = count < u.atEntityList.count ? count : u.atEntityList.count;
    
    for (AtEntity* entity in u.atEntityList)
    {
        [returnArray addObject:entity.user];
    }
    return returnArray;
}

- (void)recordAtUser:(User*)user
{
    if (user)
    {
        User* currentUser = SHARE_LOGIN_MANAGER.currentUser;
        AtEntity* entity = [currentUser.loginCached getAtEntityOfUser:user];
        if (!entity)
        {
            entity = [AtEntity insertWithOwer:currentUser User:user inContext:self.cacheManagedObjectContext];
        }
        entity.time = @(entity.time.longValue + 1);
        [currentUser.loginCached sortAtEntityList];
        [SHARE_DATA_MODEL saveCacheContext];
    }
}
- (void)recordAtUserById:(NSNumber*)userId
{
    User* user = [self getOrCreateUserById:userId.longLongValue];
    [self recordAtUser:user];
}
- (void)recordAtUserByScreenName:(NSString*)screenName
{
    User* user = [self getOrCreateUserByScreenName:screenName];
    [self recordAtUser:user];
}

@end
