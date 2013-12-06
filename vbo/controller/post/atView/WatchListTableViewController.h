//
//  WatchListTableViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-12-1.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchListTableViewController : UITableViewController
{
    NSMutableArray *selected_cell_array;
    
}
@property (strong,nonatomic)NSMutableArray *atUserArray;

@end
