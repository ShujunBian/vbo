//
//  Status.h
//  vbo
//
//  Created by wxy325 on 11/13/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*
 0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 */
typedef enum
{
    StatusVisibleTypeNormal = 0,
    StatusVisibleTypePrivate = 1,
    StatusVisibleTypeGroup = 3,
    StatusVisibleTypeCloseFriend = 4
} StatusVisibleType;


@class Comment, Status, StatusPicture, User, Group;

@interface Status : NSManagedObject

@property (nonatomic, retain) NSString * bmiddlePicURL;
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * favorited;
@property (nonatomic, retain) NSString * geo;
@property (nonatomic, retain) NSString * originalPicURL;
@property (nonatomic, retain) NSNumber * repostsCount;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * statusID;
@property (nonatomic, retain) NSString * statusMID;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * thumbnailPicURL;
@property (nonatomic, retain) NSNumber * truncated;
@property (nonatomic, retain) NSNumber * visible;
@property (nonatomic, retain) NSNumber * visibleListId;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *pictures;
@property (nonatomic, retain) NSSet *repostedBy;
@property (nonatomic, retain) Status *repostStatus;

@property (nonatomic, retain) NSSet * groups;   //此方法仅作为group中statuses属性的inverse，不实际使用
@property (nonatomic, retain) NSOrderedSet *commentList;

//List Cached
@property (nonatomic, retain) NSSet* beInTimeline;
@property (nonatomic, retain) NSSet* beInStatusList;
@property (nonatomic, retain) NSSet* beInHotStatuses;

@end

@interface Status (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addPicturesObject:(StatusPicture *)value;
- (void)removePicturesObject:(StatusPicture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

- (void)addRepostedByObject:(Status *)value;
- (void)removeRepostedByObject:(Status *)value;
- (void)addRepostedBy:(NSSet *)values;
- (void)removeRepostedBy:(NSSet *)values;

- (void)addCommentListObject:(Comment *)value;
- (void)removeCommentListObject:(Comment *)value;
- (void)addCommentList:(NSOrderedSet *)values;
- (void)removeCommentList:(NSOrderedSet *)values;



+ (Status*)insertWithId:(NSNumber*)sId InContext:(NSManagedObjectContext*)context;
- (void)updateWithDict:(NSDictionary*)dict;
@end
