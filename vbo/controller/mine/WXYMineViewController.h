//
//  WXYMineViewController.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastViewCell.h"

@interface WXYMineViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
#warning CastViewCellDelegate未实现
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
