//
//  UserCachedList.h
//  vbo
//
//  Created by wxy325 on 12/5/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AtEntity, Comment, Status, User;

@interface LoginCachedEntity : NSManagedObject

@property (nonatomic, retain) User *owner;
@property (nonatomic, retain) NSOrderedSet *homeTimeLine;
@property (nonatomic, retain) NSOrderedSet *followingList;
@property (nonatomic, retain) NSOrderedSet *followedList;
@property (nonatomic, retain) NSOrderedSet *commentList;
@property (nonatomic, retain) NSOrderedSet *atEntityList;
@end

@interface LoginCachedEntity (CoreDataGeneratedAccessors)
- (void)addHomeTimeLineObject:(Status*)value;
- (void)removeHomeTimeLineObject:(Status*)value;
- (void)addHomeTimeLine:(NSOrderedSet*)value;
- (void)removeHomeTimeLine:(NSOrderedSet*)value;

- (void)sortAtEntityList;
- (AtEntity*)getAtEntityOfUser:(User*)user;
/*
- (void)insertObject:(Status *)value inHomeTimeLineAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHomeTimeLineAtIndex:(NSUInteger)idx;
- (void)insertHomeTimeLine:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHomeTimeLineAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHomeTimeLineAtIndex:(NSUInteger)idx withObject:(Status *)value;
- (void)replaceHomeTimeLineAtIndexes:(NSIndexSet *)indexes withHomeTimeLine:(NSArray *)values;
- (void)addHomeTimeLineObject:(Status *)value;
- (void)removeHomeTimeLineObject:(Status *)value;
- (void)addHomeTimeLine:(NSOrderedSet *)values;
- (void)removeHomeTimeLine:(NSOrderedSet *)values;
- (void)insertObject:(User *)value inFollowingListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowingListAtIndex:(NSUInteger)idx;
- (void)insertFollowingList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowingListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowingListAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceFollowingListAtIndexes:(NSIndexSet *)indexes withFollowingList:(NSArray *)values;
- (void)addFollowingListObject:(User *)value;
- (void)removeFollowingListObject:(User *)value;
- (void)addFollowingList:(NSOrderedSet *)values;
- (void)removeFollowingList:(NSOrderedSet *)values;
- (void)insertObject:(User *)value inFollowedListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowedListAtIndex:(NSUInteger)idx;
- (void)insertFollowedList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowedListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowedListAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceFollowedListAtIndexes:(NSIndexSet *)indexes withFollowedList:(NSArray *)values;
- (void)addFollowedListObject:(User *)value;
- (void)removeFollowedListObject:(User *)value;
- (void)addFollowedList:(NSOrderedSet *)values;
- (void)removeFollowedList:(NSOrderedSet *)values;
- (void)insertObject:(Comment *)value inCommentListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentListAtIndex:(NSUInteger)idx;
- (void)insertCommentList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentListAtIndex:(NSUInteger)idx withObject:(Comment *)value;
- (void)replaceCommentListAtIndexes:(NSIndexSet *)indexes withCommentList:(NSArray *)values;
- (void)addCommentListObject:(Comment *)value;
- (void)removeCommentListObject:(Comment *)value;
- (void)addCommentList:(NSOrderedSet *)values;
- (void)removeCommentList:(NSOrderedSet *)values;
- (void)insertObject:(AtEntity *)value inAtEntityListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAtEntityListAtIndex:(NSUInteger)idx;
- (void)insertAtEntityList:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAtEntityListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAtEntityListAtIndex:(NSUInteger)idx withObject:(AtEntity *)value;
- (void)replaceAtEntityListAtIndexes:(NSIndexSet *)indexes withAtEntityList:(NSArray *)values;
- (void)addAtEntityListObject:(AtEntity *)value;
- (void)removeAtEntityListObject:(AtEntity *)value;
- (void)addAtEntityList:(NSOrderedSet *)values;
- (void)removeAtEntityList:(NSOrderedSet *)values;
 */
@end
