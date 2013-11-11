//
//  NSNotificationCenter+Addition.h
//  vbo
//
//  Created by Emerson on 13-11-11.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Addition)

+ (void)unregister:(id)target;

+ (void)postDidFetchCurrentUserNameNotification;
+ (void)registerDidFetchCurrentUserNameNotificationWithSelector:(SEL)aSelector target:(id)aTarget;

@end
