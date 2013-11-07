//
//  Comment.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Status, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * commentID;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * commentMID;
@property (nonatomic, retain) Status *status;
@property (nonatomic, retain) User *user;

+ (Comment*)insertWithId:(NSNumber*)cId InContest:(NSManagedObjectContext*)context;

@end
