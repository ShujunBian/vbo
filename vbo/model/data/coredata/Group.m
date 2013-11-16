//
//  Group.m
//  vbo
//
//  Created by wxy325 on 11/14/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "Group.h"
#import "User.h"
#import "NSDictionary+noNilValueForKey.h"


@implementation Group

@dynamic groupId;
@dynamic name;
@dynamic mode;
@dynamic visible;
@dynamic likeCount;
@dynamic memberCount;
@dynamic groupDescription;
@dynamic profileImageUrl;
@dynamic createdAt;
@dynamic users;
@dynamic owner;
@dynamic statuses;

+ (Group*)insertWithId:(NSNumber*)gId inContext:(NSManagedObjectContext*)context
{
    Group* group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:context];
    group.groupId = gId;
    return group;
}
- (void)updateWithDict:(NSDictionary*)dict
{
    self.name = [dict noNilValueForKey:@"name"];
    self.mode = [dict noNilValueForKey:@"mode"];
    self.visible = [dict noNilValueForKey:@"visible"];
    self.likeCount = [dict noNilValueForKey:@"like_count"];
    self.memberCount = [dict noNilValueForKey:@"member_count"];
    self.groupDescription = [dict noNilValueForKey:@"description"];
#warning tag暂不处理
    self.profileImageUrl = [dict noNilValueForKey:@"profile_image_url"];
}

@end
