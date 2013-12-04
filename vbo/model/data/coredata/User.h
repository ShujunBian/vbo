//
//  User.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Status;
@class Comment;

@interface User : NSManagedObject
//各项属性含义参看 http://open.weibo.com/wiki/2/users/show
@property (nonatomic, retain) NSString * blogURL;
@property (nonatomic, retain) NSString * cityCode;
@property (nonatomic, retain) NSString * domain;
@property (nonatomic, retain) NSNumber * followersCount;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * provinceCode;
@property (nonatomic, retain) NSString * screenName;
@property (nonatomic, retain) NSString * userDescription;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * profileImageUrl;
@property (nonatomic, retain) NSNumber * friendCount;
@property (nonatomic, retain) NSNumber * statusCount;
@property (nonatomic, retain) NSNumber * favouritesCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * following;
@property (nonatomic, retain) NSNumber * allowAllActMessage;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSNumber * geoEnabled;
@property (nonatomic, retain) NSNumber * verified;
@property (nonatomic, retain) NSNumber * allowAllComment;
@property (nonatomic, retain) NSString * avatarLargeUrl;
@property (nonatomic, retain) NSString * verifiedReason;
@property (nonatomic, retain) NSNumber * followMe;
@property (nonatomic, retain) NSNumber * onlineStatus;
@property (nonatomic, retain) NSNumber * biFollowersCount;
@property (nonatomic, retain) NSOrderedSet *statuses;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *ownGroups;
@property (nonatomic, retain) NSSet *groups;    //此属性仅作为group的users属性的相反属性，不使用
@property (nonatomic, retain) NSSet *followedUsers;
@property (nonatomic, retain) NSSet *followingUsers;
@property (nonatomic, retain) NSOrderedSet *followingList;
@property (nonatomic, retain) NSOrderedSet *followedList;
@property (nonatomic, retain) NSSet *beInFollowingList;
@property (nonatomic, retain) NSSet *beInFollowedList;

//List cached
@property (nonatomic, retain) NSOrderedSet* homeTimeLine;

@end

@interface User (CoreDataGeneratedAccessors)


//- (void)insertObject:(Status *)value inStatusesAtIndex:(NSUInteger)idx;
//- (void)removeObjectFromStatusesAtIndex:(NSUInteger)idx;
//- (void)insertStatuses:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
//- (void)removeStatusesAtIndexes:(NSIndexSet *)indexes;
//- (void)replaceObjectInStatusesAtIndex:(NSUInteger)idx withObject:(Status *)value;
//- (void)replaceStatusesAtIndexes:(NSIndexSet *)indexes withStatuses:(NSArray *)values;

- (void)addStatusesObject:(Status *)value;
- (void)removeStatusesObject:(Status *)value;
- (void)addStatuses:(NSOrderedSet *)values;
- (void)removeStatuses:(NSOrderedSet *)values;


- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addFollowedUsersObject:(User *)value;
- (void)removeFollowedUsersObject:(User *)value;
- (void)addFollowedUsers:(NSSet *)values;
- (void)removeFollowedUsers:(NSSet *)values;

- (void)addFollowingUsersObject:(User *)value;
- (void)removeFollowingUsersObject:(User *)value;
- (void)addFollowingUsers:(NSSet *)values;
- (void)removeFollowingUsers:(NSSet *)values;


+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context;

- (void)updateWithDict:(NSDictionary*)dict;

@end
