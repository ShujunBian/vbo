//
//  Comment.m
//  vbo
//
//  Created by wxy325 on 11/13/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "Comment.h"
#import "Status.h"
#import "User.h"
#import "NSDictionary+noNilValueForKey.h"
#import "NSDate+Addition.h"

@implementation Comment

@dynamic commentID;
@dynamic commentMID;
@dynamic createdAt;
@dynamic source;
@dynamic text;
@dynamic status;
@dynamic user;
@dynamic repliedComments;
@dynamic replyComment;

+ (Comment*)insertWithId:(NSNumber*)cId InContest:(NSManagedObjectContext*)context;
{
    Comment* c = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
    c.commentID = cId;
    return c;
}

- (void)updateWithDict:(NSDictionary*)dict
{
    self.createdAt = [NSDate dateFromStringRepresentation:[dict noNilValueForKey:@"created_at"]];
    self.text = [dict noNilValueForKey:@"text"];
    self.source = [dict noNilValueForKey:@"source"];
    self.commentMID = [dict noNilValueForKey:@"mid"];
}


@end
