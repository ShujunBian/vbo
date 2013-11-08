//
//  Comment.m
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "Comment.h"
#import "Status.h"
#import "User.h"


@implementation Comment

@dynamic createdAt;
@dynamic commentID;
@dynamic text;
@dynamic source;
@dynamic commentMID;
@dynamic status;
@dynamic user;

+ (Comment*)insertWithId:(NSNumber*)cId InContest:(NSManagedObjectContext*)context;
{
    Comment* c = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:context];
    c.commentID = cId;
    return c;
}

@end