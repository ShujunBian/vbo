//
//  AtEntity.h
//  vbo
//
//  Created by wxy325 on 12/5/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User,UserCachedList;

@interface AtEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) UserCachedList *owner;
@property (nonatomic, retain) User *user;

+ (AtEntity*)insertWithOwer:(User*)owner User:(User*)user inContext:(NSManagedObjectContext*)context;

@end
