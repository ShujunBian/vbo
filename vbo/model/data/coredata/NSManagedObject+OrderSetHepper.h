//
//  NSManagedObject+OrderSetHepper.h
//  vbo
//
//  Created by wxy325 on 12/4/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface NSManagedObject (OrderSetHepper)


- (void)addOrderSetObject:(NSManagedObject*)value forKey:(NSString*)key;
- (void)removeOrderSetObject:(NSManagedObject*)value forKey:(NSString*)key;
- (void)addOrderSet:(NSOrderedSet*)value forKey:(NSString*)key;
- (void)removeOrderSet:(NSOrderedSet*)value forKey:(NSString*)key;


@end
