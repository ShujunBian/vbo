//
//  User.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "User.h"
#import "Status.h"


@implementation User

@dynamic blogURL;
@dynamic cityCode;
@dynamic domain;
@dynamic followersCount;
@dynamic gender;
@dynamic location;
@dynamic provinceCode;
@dynamic screenName;
@dynamic userDescription;
@dynamic userID;
@dynamic name;
@dynamic profileImageUrl;
@dynamic friendCount;
@dynamic statusCount;
@dynamic favouritesCount;
@dynamic createdAt;
@dynamic following;
@dynamic allowAllActMessage;
@dynamic remark;
@dynamic geoEnabled;
@dynamic verified;
@dynamic allowAllComment;
@dynamic avatarLargeUrl;
@dynamic verifiedReason;
@dynamic followMe;
@dynamic onlineStatus;
@dynamic biFollowersCount;
@dynamic statuses;
@dynamic comments;

+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context
{
    User* u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    u.userID = uId;
    return u;
}

@end
