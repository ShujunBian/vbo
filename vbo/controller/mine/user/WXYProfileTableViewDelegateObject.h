//
//  WXYProfileTableViewDelegateObject.h
//  vbo
//
//  Created by wxy325 on 12/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class User;

@interface WXYProfileTableViewDelegateObject : NSObject <UITableViewDataSource, UITableViewDelegate>


- (id)initWithTableView:(UITableView*)tableView;
- (void)bind:(User*)user;
@end
