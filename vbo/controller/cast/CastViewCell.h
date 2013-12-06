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

@protocol CastViewCellDelegate <NSObject>

@optional
- (void)clickCommentButtonByStatus:(Status *)status;
- (void)clickRepostButtonByStatus:(Status *)status;
- (void)clickMoreButtonByStatus:(Status *)status;
- (void)clickUrl:(NSString*)url;
@required
- (void)presentDetailImageViewWithImageView:(UIImageView *)imageView
                         withInitalRect:(CGRect)initalRect;

@end

@interface CastViewCell : UITableViewCell

/*! 通过微博Status设置CastViewCell
 * \param currentCellStatus 该Cell对应的微博Status
 * \param isInCastView 该Cell是否在CastView中（即是否显示转发，评论等按钮）
 */

- (void)setCellWithWeiboStatus:(Status *)currentCellStatus
                  isInCastView:(BOOL)isInCastView;

/*! 获得转发的View的高度
 * \param status 转发的status内容
 */

+ (float)getHeightofCastRepostViewByStatus:(Status *) status;

@property (nonatomic, weak) id<CastViewCellDelegate> delegateForCastViewCell;

@end
