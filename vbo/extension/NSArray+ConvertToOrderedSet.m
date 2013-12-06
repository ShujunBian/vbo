//
//  NSArray+ConvertToOrderedSet.m
//  vbo
//
//  Created by wxy325 on 12/4/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "NSArray+ConvertToOrderedSet.h"

@implementation NSArray (ConvertToOrderedSet)

- (NSOrderedSet*)convertToOrderedSet
{
    return [[NSOrderedSet alloc] initWithArray:self];
}

@end
