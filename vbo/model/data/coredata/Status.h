//
//  Status.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User, StatusPicture;

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


@interface Status : NSManagedObject

//各项属性含义参看 http://open.weibo.com/wiki/2/statuses/home_timeline

////////////
//此三个图片URL属性在多图微博里仍然存在
@property (nonatomic, retain) NSString * bmiddlePicURL;
@property (nonatomic, retain) NSString * thumbnailPicURL;
@property (nonatomic, retain) NSString * originalPicURL;
////////////
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * favorited;

@property (nonatomic, retain) NSNumber * repostsCount;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * statusID;
@property (nonatomic, retain) NSString * text;

@property (nonatomic, retain) NSNumber * truncated;
@property (nonatomic, retain) NSNumber * visible;
@property (nonatomic, retain) NSNumber * visibleListId;
@property (nonatomic, retain) NSString * geo;
@property (nonatomic, retain) NSString * statusMID;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) NSSet *repostedBy;
@property (nonatomic, retain) Status *repostStatus;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *pictures;
@end

@interface Status (CoreDataGeneratedAccessors)

- (void)addRepostedByObject:(Status *)value;
- (void)removeRepostedByObject:(Status *)value;
- (void)addRepostedBy:(NSSet *)values;
- (void)removeRepostedBy:(NSSet *)values;

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addPicturesObject:(StatusPicture *)value;
- (void)removePicturesObject:(StatusPicture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

+ (Status*)insertWithId:(NSNumber*)sId InContext:(NSManagedObjectContext*)context;

- (void)updateWithDict:(NSDictionary*)dict;

@end
