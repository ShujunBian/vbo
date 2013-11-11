//
//  NSDictionary+noNullValueForKey.m
//  vbo
//
//  Created by wxy325 on 11/8/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "NSDictionary+noNilValueForKey.h"

@implementation NSDictionary (noNilValueForKey)

- (id)noNilValueForKey:(NSString*)key
{
    id value = self[key];
    if ([value isKindOfClass:[NSNull class]])
    {
        value = nil;
    }
    return value;
}

@end
