//
//  NSManagedObject+OrderSetHepper.m
//  vbo
//
//  Created by wxy325 on 12/4/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "NSManagedObject+OrderSetHepper.h"

@implementation NSManagedObject (OrderSetHepper)

- (void)addOrderSetObject:(NSManagedObject*)value forKey:(NSString*)key
{
    NSMutableOrderedSet* set = [self mutableOrderedSetValueForKey:key];
    [set addObject:value];
}
- (void)removeOrderSetObject:(NSManagedObject*)value forKey:(NSString*)key
{
    NSMutableOrderedSet* set = [self mutableOrderedSetValueForKey:key];
    [set removeObject:value];
}
- (void)addOrderSet:(NSOrderedSet*)value forKey:(NSString*)key
{
    NSMutableOrderedSet* set = [self mutableOrderedSetValueForKey:key];
    [set addObjectsFromArray:value.array];
}
- (void)removeOrderSet:(NSOrderedSet*)value forKey:(NSString*)key
{
    NSMutableOrderedSet* set = [self mutableOrderedSetValueForKey:key];
    [set removeObjectsInArray:value.array];
}

@end
