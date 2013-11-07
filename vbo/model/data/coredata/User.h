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
@property (nonatomic, retain) NSNumber * createdAt;
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
@property (nonatomic, retain) NSSet *statuses;
@property (nonatomic, retain) NSSet *comments;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(Status *)value;
- (void)removeStatusesObject:(Status *)value;
- (void)addStatuses:(NSSet *)values;
- (void)removeStatuses:(NSSet *)values;

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

+ (User*)insertWithId:(NSNumber*)uId InContext:(NSManagedObjectContext*)context;

@end
