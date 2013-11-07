//
//  WXYDataModel.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYDataModel.h"
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


@end
