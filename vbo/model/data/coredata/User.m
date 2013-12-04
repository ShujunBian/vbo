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

@implementation User
@dynamic beAted;
@dynamic atEntityList;
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

@dynamic followedList;
@dynamic followingList;
@dynamic statusList;
@dynamic beInFollowedList;
@dynamic beInFollowingList;
@dynamic homeTimeLine;

+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context
{
    User* u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    u.userID = uId;
    return u;
}

- (void)updateWithDict:(NSDictionary*)dict
{
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
    self.following = [dict noNilValueForKey:@"following"];
    self.allowAllActMessage = [dict noNilValueForKey:@"allow_all_act_msg"];
    self.geoEnabled = [dict noNilValueForKey:@"geo_enabled"];
    self.verified = [dict noNilValueForKey:@"verified"];
    self.allowAllComment = [dict noNilValueForKey:@"allow_all_comment"];
    self.avatarLargeUrl = [dict noNilValueForKey:@"avatar_large"];
    self.verifiedReason = [dict noNilValueForKey:@"verified_reason"];
    self.followMe = [dict noNilValueForKey:@"follow_me"];
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


- (NSOrderedSet*)homeTimeLine
{
    return [self mutableOrderedSetValueForKey:@"homeTimeLine"];
}

- (void)addHomeTimeLineObject:(Status*)value
{
    [self addOrderSetObject:value forKey:@"homeTimeLine"];
}
- (void)removeHomeTimeLineObject:(Status*)value
{
    [self removeOrderSetObject:value forKey:@"homeTimeLine"];
}
- (void)addHomeTimeLine:(NSOrderedSet*)value
{
    [self addOrderSet:value forKey:@"homeTimeLine"];
}
- (void)removeHomeTimeLine:(NSOrderedSet*)value
{
    [self removeOrderSet:value forKey:@"homeTimeLine"];
}

- (NSOrderedSet*)atEntityList
{
    return  [self mutableOrderedSetValueForKey:@"atEntityList"];
}

- (void)sortAtEntityList
{
    NSMutableOrderedSet* set = [self mutableOrderedSetValueForKey:@"atEntityList"];
    [set sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        AtEntity* l = (AtEntity*)obj1;
        AtEntity* r = (AtEntity*)obj2;
        return - [l.time compare:r.time];
    }];
}
- (AtEntity*)getAtEntityOfUser:(User*)user
{
    AtEntity* e = nil;
    for (AtEntity* entity in self.atEntityList)
    {
        if ([entity.user isEqual:user])
        {
            e = entity;
        }
    }
    return e;
}
@end
