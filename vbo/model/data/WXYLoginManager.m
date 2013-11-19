//
//  WXYLoginManager.m
//  vbo
//
//  Created by wxy325 on 11/19/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYLoginManager.h"
#define  kLoginUserListArchiverKey @"LOGIN_USER_LIST_ARCHIVER_KEY"
#define kLoginUserInfoFileName @"loginUserInfo"
@interface WXYLoginManager ()

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
@synthesize loginUserList = _loginUserList;

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
    if (!_loginUserList)
    {
        _loginUserList = [self unarchiveLoginUserInfoList];
    }
    return _loginUserList;
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


@end
