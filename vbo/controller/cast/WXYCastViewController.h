//
//  WXYCastViewController.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastViewCell.h"

@interface WXYCastViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,CastViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
