//
//  StatusPicture.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "StatusPicture.h"
#import "Status.h"


@implementation StatusPicture

@dynamic bmiddlePicURL;
@dynamic originalPicURL;
@dynamic thumbnailPicURL;
@dynamic status;

+ (StatusPicture*)insertInContext:(NSManagedObjectContext*)context
{
    StatusPicture* p = nil;
    p = [NSEntityDescription insertNewObjectForEntityForName:@"StatusPicture" inManagedObjectContext:context];
    return p;
}

@end
