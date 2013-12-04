//
//  ComRepViewController.h
//  vbo
//
//  Created by Emerson on 13-11-19.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;

typedef enum{
	CommentType = 0,
	RepostType,
	MoreType,
} ComRepMoreType;

@interface ComRepViewController : UIViewController

@property (nonatomic, strong) Status * currentStatus;
@property (nonatomic) ComRepMoreType currentType;

@end
