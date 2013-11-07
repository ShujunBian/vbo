//
//  Status.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Status, User;

@interface Status : NSManagedObject

@property (nonatomic, retain) NSString * bmiddlePicURL;
@property (nonatomic, retain) NSNumber * commentsCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * favorited;
@property (nonatomic, retain) NSString * originalPicURL;
@property (nonatomic, retain) NSNumber * repostsCount;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * statusID;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * thumbnailPicURL;
@property (nonatomic, retain) NSNumber * truncated;
@property (nonatomic, retain) NSString * geo;
@property (nonatomic, retain) NSString * statusMID;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) NSSet *repostedBy;
@property (nonatomic, retain) Status *repostStatus;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Status (CoreDataGeneratedAccessors)

- (void)addRepostedByObject:(Status *)value;
- (void)removeRepostedByObject:(Status *)value;
- (void)addRepostedBy:(NSSet *)values;
- (void)removeRepostedBy:(NSSet *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
