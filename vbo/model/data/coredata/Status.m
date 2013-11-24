//
//  Status.m
//  vbo
//
//  Created by wxy325 on 11/13/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "Status.h"
#import "Comment.h"
#import "Status.h"
#import "StatusPicture.h"
#import "User.h"
#import "NSDictionary+noNilValueForKey.h"
#import "NSDate+Addition.h"


@implementation Status

@dynamic bmiddlePicURL;
@dynamic commentsCount;
@dynamic createdAt;
@dynamic favorited;
@dynamic geo;
@dynamic originalPicURL;
@dynamic repostsCount;
@dynamic source;
@dynamic statusID;
@dynamic statusMID;
@dynamic text;
@dynamic thumbnailPicURL;
@dynamic truncated;
@dynamic visible;
@dynamic visibleListId;
@dynamic author;
@dynamic comments;
@dynamic pictures;
@dynamic repostedBy;
@dynamic repostStatus;
@dynamic groups;


+ (Status*)insertWithId:(NSNumber*)sId InContext:(NSManagedObjectContext*)context
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
    
    NSDictionary* visibleDict = [dict noNilValueForKey:@"visible"];
    self.visible = [visibleDict noNilValueForKey:@"type"];
    self.visibleListId = [dict noNilValueForKey:@"list_id"];
    
}

@end
