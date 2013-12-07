//
//  WXYUserProfileViewController.h
//  vbo
//
//  Created by wxy325 on 12/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYProfileTableViewDelegateObject.h"

@class User;

@interface WXYUserProfileViewController : UIViewController<WXYProfileDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) User* user;
@end
