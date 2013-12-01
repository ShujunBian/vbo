//
//  WatchListTableViewCell.h
//  vbo
//
//  Created by Pursue_finky on 13-12-1.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *selectedView;
@property (strong, nonatomic) IBOutlet UIImageView *userHeadPhoto;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIImageView *contact_infoView;

@end
