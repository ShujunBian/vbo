//
//  ComReqDetailCell.m
//  vbo
//
//  Created by Emerson on 13-11-20.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "ComReqDetailCell.h"
#import "Comment.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "NSDate+Addition.h"

#define contentLabelLineSpace 6.0

@interface ComReqDetailCell()

@property (nonatomic, weak) IBOutlet UILabel * commentUserNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView * commentUserAvatorImageView;
@property (nonatomic, weak) IBOutlet UITextView * commentTextView;
@property (nonatomic, weak) IBOutlet UILabel * commentTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView * shadowImageView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint * commentTextViewHeightConstraint;

@property (nonatomic, strong) Comment * currentComment;

@end

@implementation ComReqDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellWithWeiboComment:(Comment *)comment
{
    [self.contentView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];
    
    self.currentComment = comment;
    
    [_commentTimeLabel setText:[_currentComment.createdAt customString]];
    
    [_commentUserNameLabel setText:comment.user.name];
    [_commentUserNameLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
    
    [_commentUserAvatorImageView setImage:nil];
    [_commentUserAvatorImageView setImageFromURLString:comment.user.profileImageUrl
                                      placeHolderImage:nil
                                             animation:YES
                                            completion:nil];
    _commentUserAvatorImageView.layer.cornerRadius = 17.5;
    _commentUserAvatorImageView.layer.masksToBounds = YES;

    
    [_commentTextView setAttributedText:[self commentContentLabelAttributedString]];
    _commentTextViewHeightConstraint.constant = [UITextViewHelper HeightForAttributedString:_commentTextView.attributedText
                                                                                  withWidth:254.0];
    [_commentTextView setScrollEnabled:NO];
    
    UIGraphicsBeginImageContext(CGSizeMake(320.0, 1.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0] CGColor]);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 320.0, 0.0);
    CGContextStrokePath(context);
    UIImage * linePic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_shadowImageView setImage:linePic];
}

- (NSMutableAttributedString *)commentContentLabelAttributedString
{
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:_currentComment.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:contentLabelLineSpace];
    
    return contentString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
