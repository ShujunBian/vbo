//
//  Group.h
//  vbo
//
//  Created by wxy325 on 11/14/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSNumber * groupId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * visible;
@property (nonatomic, retain) NSNumber * likeCount;
@property (nonatomic, retain) NSNumber * memberCount;
@property (nonatomic, retain) NSString * groupDescription;
@property (nonatomic, retain) NSString * profileImageUrl;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet *users;
@property (nonatomic, retain) User *owner;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
