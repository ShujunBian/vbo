//
//  WXYLoginManager.m
//  vbo
//
//  Created by wxy325 on 11/19/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYLoginManager.h"
#define  kLoginUserListArchiverKey @"LOGIN_USER_LIST_ARCHIVER_KEY"
#define kLoginUserInfoFileName @"/loginUserInfo"
@interface WXYLoginManager ()

@property (strong, nonatomic) NSMutableArray* loginUserMutableList;
//Document
-(NSURL*)applicationDocumentsDirectory;
-(NSString*)applicationDocumentsDirectoryPath;

//Write And Read User Info
- (void)saveUserInfo;
- (NSData*)archiveLoginUserInfoList;
- (NSData*)getLoginUserInfoListDataFromFile;
- (NSArray*)unarchiveLoginUserInfoList;
@end

@implementation WXYLoginManager

@dynamic currentUserInfo;
@dynamic loginUserList;
@synthesize loginUserMutableList = _loginUserMutableList;

#pragma mark - Static Method
#pragma mark Singleton
+ (WXYLoginManager*)shareLoginManager
{
    static WXYLoginManager* s_dataModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_dataModel = [[WXYLoginManager alloc] init];
    });
    return s_dataModel;
}

#pragma mark - Getter And Setter Method
- (NSArray*)loginUserList
{
    return self.loginUserMutableList;
}

- (NSMutableArray*)loginUserMutableList
{
    if (!_loginUserMutableList)
    {
        _loginUserMutableList = [[NSMutableArray alloc] initWithArray: [self unarchiveLoginUserInfoList]];
    }
    return _loginUserMutableList;
}

- (LoginUserInfo*)currentUserInfo
{
    LoginUserInfo* info = nil;
    if (self.loginUserList.count)
    {
        info = self.loginUserList[0];
    }
    return info;
}

#pragma mark - Document
-(NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSString*)applicationDocumentsDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (NSString*)getDataPath
{
    NSString* documentPath = [self applicationDocumentsDirectoryPath];
    NSString* dataPath = [documentPath stringByAppendingString:kLoginUserInfoFileName];
    return dataPath;
}

#pragma mark - Write And Read Login User Info
- (void)saveUserInfo
{
    NSData* loginUserData = [self archiveLoginUserInfoList];
    NSString* dataPath = [self getDataPath];
    NSError* error;
    [loginUserData writeToFile:dataPath options:NSDataWritingFileProtectionComplete error:&error];
    
}
- (NSData*)archiveLoginUserInfoList
{
    NSMutableData* data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.loginUserList forKey:kLoginUserListArchiverKey];
    [archiver finishEncoding];
    return data;
}

- (NSData*)getLoginUserInfoListDataFromFile
{
    NSString* dataPath = [self getDataPath];
    NSData* data = [[NSData alloc] initWithContentsOfFile:dataPath];
    return data;
}
- (NSArray*)unarchiveLoginUserInfoList
{
    NSData* data = [self getLoginUserInfoListDataFromFile];
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray* array = [unarchiver decodeObjectForKey:kLoginUserListArchiverKey];
    [unarchiver finishDecoding];
    return array;
}

#pragma mark - Login And Remove
- (BOOL)changeUser:(NSString*)userId
{
    NSUInteger index = 0;
    for (; index < self.loginUserMutableList.count; index++)
    {
        LoginUserInfo* info = self.loginUserMutableList[index];
        if ([info.userId isEqualToString:userId])
        {
            break;
        }
    }
    if (index < self.loginUserMutableList.count)
    {
        [self.loginUserMutableList exchangeObjectAtIndex:index withObjectAtIndex:0];
        return YES;
    }
    else
    {
        return NO;
    }
    [self saveUserInfo];
}
- (void)loginUser:(LoginUserInfo*)info
{
    //删除原有数据
    [self removeUserInfo:info.userId];
    //加入新数据
    [self.loginUserMutableList insertObject:info atIndex:0];
    [self saveUserInfo];
}

- (void)removeUserInfo:(NSString*)userId
{
    //删除原有数据
    LoginUserInfo* oldInfo = nil;
    for (LoginUserInfo* i in self.loginUserMutableList)
    {
        if ([i.userId isEqualToString:userId])
        {
            oldInfo = i;
            break;
        }
    }
    if (oldInfo)
    {
        [self.loginUserMutableList removeObject:oldInfo];
        [self saveUserInfo];
    }
}


@end
