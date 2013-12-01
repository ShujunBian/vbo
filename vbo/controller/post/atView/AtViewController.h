//
//  atViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>



@class WatchListTableViewController;

@interface AtViewController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *hasAtCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *commonlyUsedCollectionView;
@property (strong, nonatomic) IBOutlet WatchListTableViewController*watchListTableViewController;

@property (strong, nonatomic) IBOutlet UIView *abcView;


@end
