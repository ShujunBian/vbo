//
//  LoginUserInfo.m
//  vbo
//
//  Created by wxy325 on 11/19/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "LoginUserInfo.h"

#define kUserIdKey @"USER_ID"
#define kUserNameKey @"USER_NAME"
#define kAccessTokenKey @"ACCESS_TOKEN"
#define kExpireDateKey @"EXPIRE_DATE"

@implementation LoginUserInfo


#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:self.userId forKey:kUserIdKey];
    [aCoder encodeObject:self.userName forKey:kUserNameKey];
    [aCoder encodeObject:self.accessToken forKey:kAccessTokenKey];
    [aCoder encodeObject:self.expireDate forKey:kExpireDateKey];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.userId = [aDecoder decodeObjectForKey:kUserIdKey];
        self.userName = [aDecoder decodeObjectForKey:kUserNameKey];
        self.accessToken = [aDecoder decodeObjectForKey:kAccessTokenKey];
        self.expireDate = [aDecoder decodeObjectForKey:kExpireDateKey];
    }
    return self;
}

#pragma makr - NSCopy
- (id)copyWithZone:(NSZone *)zone
{
    LoginUserInfo* copy = [[[LoginUserInfo class] allocWithZone:zone] init];
    
    copy.userId = [self.userId copyWithZone:zone];
    copy.userName = [self.userName copyWithZone:zone];
    copy.accessToken = [self.accessToken copyWithZone:zone];
    copy.expireDate = [self.expireDate copyWithZone:zone];
    
    return copy;
    
}



@end
