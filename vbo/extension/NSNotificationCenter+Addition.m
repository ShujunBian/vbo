//
//  NSNotificationCenter+Addition.m
//  vbo
//
//  Created by Emerson on 13-11-11.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

#define kDidFetchCurrentUserName @"kDidFetchCurrentUserName"

@implementation NSNotificationCenter (Addition)

+ (void)unregister:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}

+ (void)postDidFetchCurrentUserNameNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidFetchCurrentUserName object:nil userInfo:nil];
}

+ (void)registerDidFetchCurrentUserNameNotificationWithSelector:(SEL)aSelector target:(id)aTarget
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:aTarget selector:aSelector
                   name:kDidFetchCurrentUserName
                 object:nil];
}

@end
