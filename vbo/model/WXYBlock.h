//
//  WXYBlock.h
//  vbo
//
//  Created by wxy325 on 11/7/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#ifndef vbo_WXYBlock_h
#define vbo_WXYBlock_h
@class MKNetworkOperation;
@class Status;
@class Comment;
@class Group;
@class User;
@class NSError;

typedef void (^VoidBlock)(void);
typedef void (^ErrorBlock) (NSError* error);
typedef void (^OperationSucceedBlock)(MKNetworkOperation *completedOperation);
typedef void (^OperationErrorBlock)(MKNetworkOperation *completedOperation, NSError *error);
typedef void (^ArrayBlock)(NSArray *resultArray);

typedef void (^GroupWithCursorBlock)(Group* group, NSNumber* previousCursor, NSNumber* nextCursor);
typedef void (^StatusBlock)(Status* status);
typedef void (^CommentBlock)(Comment* comment);
typedef void (^UserBlock)(User* user);

#endif
