//
//  CastViewCell.m
//  vbo
//
//  Created by Emerson on 13-11-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastViewCell.h"
#import "WXYNetworkEngine.h"
#import "TTTAttributedLabel.h"
#import "TTTAttributedLabelHelper.h"
#import "WXYSettingManager.h"

#define weiboImageHeight 106.0
#define weiboCellBetweenHeight 10.0
#define contentLabelLineSpace 6.0
#define contentLabelPadding 10.0

@interface CastViewCell()

@property (nonatomic,weak) IBOutlet UIImageView * weiboImage;
@property (nonatomic,weak) IBOutlet UIImageView * userAvator;

@property (nonatomic,weak) IBOutlet UILabel * userNickname;
@property (nonatomic,weak) IBOutlet TTTAttributedLabel * weiboContentLabel;
@property (nonatomic,weak) IBOutlet UILabel * likeTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * commentTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * repostTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * currentTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * avatorTopSpaceConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * contentLabelHeight;

@property (weak, nonatomic) IBOutlet UIView * cellBackgroundView;

@property (nonatomic,weak) IBOutlet UIButton * likeButton;
@property (nonatomic,weak) IBOutlet UIButton * commentButton;
@property (nonatomic,weak) IBOutlet UIButton * repostButton;


@end

@implementation CastViewCell
- (void)awakeFromNib
{
    //    _cellBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    _cellBackgroundView.layer.shadowOffset = CGSizeMake(0, 0.5);
    //    _cellBackgroundView.layer.shadowOpacity = 0.28;
    //    _cellBackgroundView.layer.shadowRadius = 1.0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCellWithWeiboStatus:(Status *)currentCellStatus
{
    [_cellBackgroundView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];

    //    [cell.weiboContentLabel setBackgroundColor:[UIColor greenColor]];
    [_weiboContentLabel setAttributedText:[self weiboContentLabelAttributedStringByStatus:currentCellStatus]];
    _contentLabelHeight.constant = [TTTAttributedLabelHelper HeightForAttributedString:[self weiboContentLabelAttributedStringByStatus:currentCellStatus]
                                                                           withPadding:contentLabelPadding];

    if (currentCellStatus.bmiddlePicURL != nil) {
        _avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
    }
    else {
        _avatorTopSpaceConstaint.constant = weiboCellBetweenHeight;
    }
    //    NSLog(@"the %ld cell height of constant is %f",(long)[indexPath row],cell.avatorTopSpaceConstaint.constant);
    
    [_weiboImage setImage:nil];
    NSURL *anImageURL = [NSURL URLWithString:currentCellStatus.bmiddlePicURL];
    [_weiboImage setImageFromURL:anImageURL placeHolderImage:nil animation:YES completion:nil];
    _weiboImage.contentMode = UIViewContentModeScaleAspectFill;
    _weiboImage.clipsToBounds = YES;
    
    [_userAvator setImageFromURLString:currentCellStatus.author.profileImageUrl
                      placeHolderImage:nil animation:YES completion:nil];
    _userAvator.layer.cornerRadius = 16.0;
    _userAvator.layer.masksToBounds = YES;
    
    [_userNickname setText:currentCellStatus.author.screenName];
    [_userNickname setTextColor:SHARE_SETTING_MANAGER.themeColor];
    
    [_currentTimeLabel setTextColor:SHARE_SETTING_MANAGER.castViewTableCellTimeLabelColor];
    
    [_likeTimesLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
    [_commentTimesLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
    [_repostTimesLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
}

//- (float)cellContentHeightForRowAtIndex:(NSInteger)row
//{
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)[self weiboContentLabelAttributedStringAtIndex:row]);
//    CFRange fitRange;
//    CFRange textRange = CFRangeMake(0, [self weiboContentLabelAttributedStringAtIndex:row].length);
//    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(288, CGFLOAT_MAX), &fitRange);
//    CFRelease(framesetter);
//    
//    return frameSize.height + contentLabelPadding;
//}

- (NSMutableAttributedString *)weiboContentLabelAttributedStringByStatus:(Status *)currentCellStatus
{
    NSMutableAttributedString * contentString = [TTTAttributedLabelHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentCellStatus.text]
                                                                              WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                                 withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                             withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                                withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                          withLabelLineSpace:contentLabelLineSpace];
    
    return contentString;
}

@end
