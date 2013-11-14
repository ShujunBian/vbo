//
//  CastViewCell.h
//  vbo
//
//  Created by Emerson on 13-11-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTAttributedLabel;
@class Status;

@interface CastViewCell : UITableViewCell

/*! 通过微博Status设置CastViewCell
 * \param currentCellStatus 该Cell对应的微博Status
 */

- (void)setCellWithWeiboStatus:(Status *)currentCellStatus;

@end
