//
//  atViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AtSelectedViewController.h"

@class WatchListTableViewController;

@class User;

typedef void(^SendSelectedUsersBlock)(NSArray *array);

typedef void (^AtVCBlock)(User* user);

@interface AtViewController : UIViewController

//@property (strong, nonatomic) IBOutlet UIView *selectedDisplayView;

@property (strong,nonatomic) AtSelectedViewController *atSelectedVC;



@property (strong, nonatomic) IBOutlet UICollectionView *commonlyUsedCollectionView;


@property(strong,nonatomic)WatchListTableViewController* watchListTvc;

@property (strong, nonatomic) IBOutlet UIView *abcView;

@property (strong ,nonatomic) NSMutableArray *selectedUserArray;

//@property (strong,nonatomic)SendSelectedUsersBlock *sendSelectedUsersBlock;



@end
