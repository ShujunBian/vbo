//
//  Status.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "Status.h"
#import "Status.h"
#import "User.h"


@implementation Status

@dynamic bmiddlePicURL;
@dynamic commentsCount;
@dynamic createdAt;
@dynamic favorited;
@dynamic originalPicURL;
@dynamic repostsCount;
@dynamic source;
@dynamic statusID;
@dynamic text;
@dynamic thumbnailPicURL;
@dynamic truncated;
@dynamic geo;
@dynamic statusMID;
@dynamic author;
@dynamic repostedBy;
@dynamic repostStatus;
@dynamic comments;


+ (Status*)insertWithId:(NSNumber*)sId InContext:(NSManagedObjectContext*)context;
{
    Status* s = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:context];
    s.statusID = sId;
    return s;
}

- (void)updateWithDict:(NSDictionary*)dict
{
    
}

@end
