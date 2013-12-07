//
//  UserCachedList.m
//  vbo
//
//  Created by wxy325 on 12/5/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "LoginCachedEntity.h"
#import "AtEntity.h"
#import "Comment.h"
#import "Status.h"
#import "User.h"
#import "NSManagedObject+OrderSetHepper.h"


@implementation LoginCachedEntity

@dynamic owner;
@dynamic homeTimeLine;
@dynamic followingList;
@dynamic followedList;
@dynamic commentList;
@dynamic atEntityList;
@dynamic hotStatuses;


+ (LoginCachedEntity*)insertWithOwer:(User*)owner inContext:(NSManagedObjectContext*)context
{
    LoginCachedEntity* e = [NSEntityDescription insertNewObjectForEntityForName:@"LoginCachedEntity" inManagedObjectContext:context];
    owner.loginCached = e;
    return e;
}

#pragma mark Home Time Line
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

#pragma mark Hot Statuses
- (NSOrderedSet*)hotStatuses
{
    return [self mutableOrderedSetValueForKey:@"homeTimeLine"];
}
- (void)addHotStatusesObject:(Status*)value
{
    [self addOrderSetObject:value forKey:@"homeTimeLine"];
}
- (void)removeHotStatusesObject:(Status*)value
{
    [self removeOrderSetObject:value forKey:@"homeTimeLine"];
}
- (void)addHotStatuses:(NSOrderedSet*)value
{
    [self addOrderSet:value forKey:@"homeTimeLine"];
}
- (void)removeHotStatuses:(NSOrderedSet*)value
{
    [self removeOrderSet:value forKey:@"homeTimeLine"];
}

#pragma mark At Entity List
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
