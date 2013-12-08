//
//  User.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "User.h"
#import "Status.h"
#import "AtEntity.h"
#import "NSDictionary+noNilValueForKey.h"
#import "NSDate+Addition.h"
#import "NSManagedObject+OrderSetHepper.h"
#import "WXYLoginManager.h"

@implementation User
@dynamic loginCached;
@dynamic beAted;
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
@dynamic ownGroups;
@dynamic groups;
@dynamic followedUsers;
@dynamic followingUsers;
@dynamic statusList;
@dynamic beInFollowedList;
@dynamic beInFollowingList;

- (NSNumber*)followMe
{
    return @([self.followingUsers containsObject:SHARE_LOGIN_MANAGER.currentUser]);
}
- (NSNumber*)following
{
    return @([self.followedUsers containsObject:SHARE_LOGIN_MANAGER.currentUser]);
}


+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context
{
    User* u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    u.userID = uId;
    return u;
}

- (void)updateWithDict:(NSDictionary*)dict
{
    User* loginUser = SHARE_LOGIN_MANAGER.currentUser;
    
    self.userID = [dict noNilValueForKey:@"id"];
    self.screenName = [dict noNilValueForKey:@"screen_name"];
    self.name = [dict noNilValueForKey:@"name"];
    self.provinceCode = [dict noNilValueForKey:@"province"];
    self.cityCode = [dict noNilValueForKey:@"city"];
    self.location = [dict noNilValueForKey:@"location"];
    self.userDescription = [dict noNilValueForKey:@"description"];
    self.blogURL = [dict noNilValueForKey:@"url"];
    self.profileImageUrl = [dict noNilValueForKey:@"profile_image_url"];
    self.domain = [dict noNilValueForKey:@"domain"];
    self.gender = [dict noNilValueForKey:@"gender"];
    self.followersCount = [dict noNilValueForKey:@"followers_count"];
    self.friendCount = [dict noNilValueForKey:@"friends_count"];
    self.statusCount = [dict noNilValueForKey:@"statuses_count"];
    self.favouritesCount = [dict noNilValueForKey:@"favourites_count"];
    NSString* createdAtString = [dict noNilValueForKey:@"created_at"];
    self.createdAt = [NSDate dateFromStringRepresentation:createdAtString];

    NSNumber* following = [dict noNilValueForKey:@"following"];
    NSNumber* followMe = [dict noNilValueForKey:@"follow_me"];
    if (following.boolValue)
    {
        [loginUser addFollowingUsersObject:self];
    }
    else
    {
        [loginUser removeFollowingUsersObject:self];
    }
    
    if (followMe.boolValue)
    {
        [loginUser addFollowedUsersObject:self];
    }
    else
    {
        [loginUser removeFollowedUsersObject:self];
    }
    
    
    self.allowAllActMessage = [dict noNilValueForKey:@"allow_all_act_msg"];
    self.geoEnabled = [dict noNilValueForKey:@"geo_enabled"];
    self.verified = [dict noNilValueForKey:@"verified"];
    self.allowAllComment = [dict noNilValueForKey:@"allow_all_comment"];
    self.avatarLargeUrl = [dict noNilValueForKey:@"avatar_large"];
    self.verifiedReason = [dict noNilValueForKey:@"verified_reason"];

    self.onlineStatus = [dict noNilValueForKey:@"online_status"];
    self.biFollowersCount = [dict noNilValueForKey:@"bi_followers_count"];
}

#pragma mark - Order RelationShip
- (NSOrderedSet*)statuses
{
    return [self mutableOrderedSetValueForKey:@"statuses"];
}

- (void)addStatusesObject:(Status *)value
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    int index = 0;
    for (index = 0; index < orderSet.count; index++)
    {
        Status* s = orderSet[index];
        if ([value.createdAt compare:s.createdAt] == NSOrderedDescending)
        {
            break;
        }
    }
    [orderSet insertObject:value atIndex:index];
    [orderSet addObject:value];
}
- (void)removeStatusesObject:(Status *)value
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet removeObject:value];
}
- (void)addStatuses:(NSOrderedSet *)values
{
    NSMutableOrderedSet*  mutableValues = [values mutableCopy];
    [mutableValues sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
     {
         Status* l = (Status*)obj1;
         Status* r = (Status*)obj2;
         return -[l.createdAt compare:r.createdAt];
     }];
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    
    //归并排序
    int i = 0, j = 0;
    for (j = 0; j < orderSet.count; j++)
    {
        Status* v = mutableValues[i];
        Status* s = orderSet[j];
        if ([v.createdAt compare:s.createdAt] == NSOrderedDescending)
        {
            [orderSet insertObject:v atIndex:j];
            i++;
            if (i == mutableValues.count)
            {
                break;
            }
        }
    }
    if (i != mutableValues.count)
    {
        NSArray* remainArray = [mutableValues.array subarrayWithRange:NSMakeRange(i, mutableValues.count - i)];
        [orderSet addObjectsFromArray:remainArray];
    }
    
    [orderSet addObjectsFromArray:values.array];
}
- (void)removeStatuses:(NSOrderedSet *)values
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet removeObjectsInArray:values.array];
}



@end
