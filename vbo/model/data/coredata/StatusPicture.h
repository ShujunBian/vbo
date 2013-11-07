//
//  StatusPicture.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Status;

@interface StatusPicture : NSManagedObject

@property (nonatomic, retain) NSString * bmiddlePicURL;
@property (nonatomic, retain) NSString * originalPicURL;
@property (nonatomic, retain) NSString * thumbnailPicURL;
@property (nonatomic, retain) Status *status;

+ (StatusPicture*)insertInContext:(NSManagedObjectContext*)context;

@end
