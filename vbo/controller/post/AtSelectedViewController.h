//
//  AtSelectedViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface AtSelectedViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *container;
@property(strong ,nonatomic)User *selectedUser;
@property(strong ,nonatomic)User *deSelectedUser;

@property(strong,nonatomic)NSMutableArray *selectedViewArray;
@property(strong,nonatomic)NSMutableArray *correspondsToSelectedViewOfUserArray;



-(void)sendSelectedUserData:(User *)user;

-(void)sendDeSelectedUserData:(User *)user;



@end
