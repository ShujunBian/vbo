//
//  ComReqDetailCell.h
//  vbo
//
//  Created by Emerson on 13-11-20.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface ComReqDetailCell : UITableViewCell

- (void)setCellWithWeiboComment:(Comment *)comment;

@end
