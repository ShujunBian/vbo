//
//  WatchListTableViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-12-1.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYBlock.h"
@class User;
typedef void (^AtVCBlock)(User* user);

@interface WatchListTableViewController : UITableViewController
{
    NSMutableArray *selected_cell_array;    
}
@property (strong,nonatomic)NSMutableArray *atUserArray;
@property (strong, nonatomic) AtVCBlock selectedAtVCBlock;
@property (strong,nonatomic) AtVCBlock deSelectedAtVCBlock;

@end

