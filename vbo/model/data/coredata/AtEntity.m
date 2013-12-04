//
//  AtEntity.m
//  vbo
//
//  Created by wxy325 on 12/5/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "AtEntity.h"
#import "User.h"


@implementation AtEntity

@dynamic time;
@dynamic owner;
@dynamic user;

+ (AtEntity*)insertWithOwer:(User*)owner User:(User*)user inContext:(NSManagedObjectContext*)context
{
    AtEntity* u = [NSEntityDescription insertNewObjectForEntityForName:@"AtEntity" inManagedObjectContext:context];
    u.time = @(0);
    u.user = user;
    u.owner = owner;
    return u;
}

@end
