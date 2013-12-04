//
//  User.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "User.h"
#import "Status.h"
#import "NSDictionary+noNilValueForKey.h"
#import "NSDate+Addition.h"

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
@dynamic ownGroups;
@dynamic groups;
@dynamic followedUsers;
@dynamic followingUsers;

+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context
{
    User* u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    u.userID = uId;
    return u;
}

- (void)updateWithDict:(NSDictionary*)dict
{
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
#warning 需要重写，根据时间进行排序、添加
- (NSOrderedSet*)statuses
{
    return [self mutableOrderedSetValueForKey:@"statuses"];
}

- (void)addStatusesObject:(Status *)value
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet addObject:value];
}
- (void)removeStatusesObject:(Status *)value
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet removeObject:value];
}
- (void)addStatuses:(NSOrderedSet *)values
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet addObjectsFromArray:values.array];
}
- (void)removeStatuses:(NSOrderedSet *)values
{
    NSMutableOrderedSet* orderSet = [self mutableOrderedSetValueForKey:@"statuses"];
    [orderSet removeObjectsInArray:values.array];
}




- (void)addHomeTimeLineObject:(Status*)value
{

}
- (void)removeHomeTimeLineObject:(Status*)value
{

}
- (void)addHomeTimeLine:(NSOrderedSet*)value
{

}
- (void)removeHomeTimeLine:(NSOrderedSet*)value
{

}

@end
