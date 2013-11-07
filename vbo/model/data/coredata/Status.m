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
#import "NSDate+Addition.h"
#import "NSDictionary+noNilValueForKey.h"

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
@dynamic pictures;


+ (Status*)insertWithId:(NSNumber*)sId InContext:(NSManagedObjectContext*)context;
{
    Status* s = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:context];
    s.statusID = sId;
    return s;
}

- (void)updateWithDict:(NSDictionary*)dict
{
    /*
     "annotations": [],
     geo
     */
    self.text = [dict noNilValueForKey:@"text"];
    self.source = [dict noNilValueForKey:@"source"];
    self.favorited = [dict noNilValueForKey:@"favorited"];
    self.truncated = [dict noNilValueForKey:@"truncated"];
    self.repostsCount = [dict noNilValueForKey:@"reposts_count"];
    self.commentsCount = [dict noNilValueForKey:@"comments_count"];
    self.statusMID = [dict noNilValueForKey:@"mid"];
//    self.geo = [dict noNilValueForKey:@"geo"];

    self.thumbnailPicURL = [dict noNilValueForKey:@"thumbnail_pic"];
    self.bmiddlePicURL = [dict noNilValueForKey:@"bmiddle_pic"];
    self.originalPicURL = [dict noNilValueForKey:@"original_pic"];
    
    NSString* dateStr = [dict noNilValueForKey:@"created_at"];
    self.createdAt = [NSDate dateFromStringRepresentation:dateStr];
    
}

@end
