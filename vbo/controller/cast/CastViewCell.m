//
//  CastViewCell.m
//  vbo
//
//  Created by Emerson on 13-11-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastViewCell.h"
#import "WXYNetworkEngine.h"
#import "WXYSettingManager.h"

#define weiboImageHeight 106.0
#define weiboCellBetweenHeight 10.0
#define contentLabelLineSpace 6.0

@interface CastViewCell()<UITextViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIImageView * weiboImage;
@property (nonatomic, weak) IBOutlet UIImageView * userAvator;

@property (nonatomic, weak) IBOutlet UILabel * userNickname;
@property (nonatomic, weak) IBOutlet UILabel * likeTimesLabel;
@property (nonatomic, weak) IBOutlet UILabel * commentTimesLabel;
@property (nonatomic, weak) IBOutlet UILabel * repostTimesLabel;
@property (nonatomic, weak) IBOutlet UILabel * currentTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * avatorTopSpaceConstaint;

@property (weak, nonatomic) IBOutlet UIView * cellBackgroundView;

@property (nonatomic, weak) IBOutlet UIButton * likeButton;
@property (nonatomic, weak) IBOutlet UIButton * commentButton;
@property (nonatomic, weak) IBOutlet UIButton * repostButton;

@property (nonatomic, weak) IBOutlet UITextView * weiboContentTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * contentTextViewHegihtConstraint;


@end

@implementation CastViewCell
- (void)awakeFromNib
{
    //    _cellBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    _cellBackgroundView.layer.shadowOffset = CGSizeMake(0, 0.5);
    //    _cellBackgroundView.layer.shadowOpacity = 0.28;
    //    _cellBackgroundView.layer.shadowRadius = 1.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    
//    [_weiboContentTextView setBackgroundColor:[UIColor greenColor]];
    [_weiboContentTextView setAttributedText:[self weiboContentLabelAttributedStringByStatus:currentCellStatus]];
    _contentTextViewHegihtConstraint.constant = [UITextViewHelper HeightForAttributedString:_weiboContentTextView.attributedText
                                                                                  withWidth:288.0];
    [_weiboContentTextView setScrollEnabled:NO];
    _weiboContentTextView.delegate = self;
    
    if (currentCellStatus.bmiddlePicURL != nil) {
        _avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
    }
    else {
        _avatorTopSpaceConstaint.constant = weiboCellBetweenHeight;
    }
    
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

- (NSMutableAttributedString *)weiboContentLabelAttributedStringByStatus:(Status *)currentCellStatus
{
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentCellStatus.text]
                                                                              WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                                 withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                             withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                                withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                          withLabelLineSpace:contentLabelLineSpace];
    
    return contentString;
}

- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    calculateAndSetFonts(self);
    _contentTextViewHegihtConstraint.constant = [UITextViewHelper HeightForAttributedString:_weiboContentTextView.attributedText
                                                                                  withWidth:288.0];
}

#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    UIActionSheet * testActionSheet = [[UIActionSheet alloc]initWithTitle:@"Click URl"
                                                                 delegate:self
                                                        cancelButtonTitle:@"OK"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
    [testActionSheet showInView:self.superview];
//    NSLayoutManager * layoutManger = _weiboContentTextView.layoutManager;
    
    return NO;
}

#pragma mark - 根据系统设置字体调整cell高度和cell字体大小
static inline void calculateAndSetFonts(CastViewCell *aCell)
{
    static const CGFloat cellTitleTextScaleFactor = 1;
    
    NSString * weiboContentTextStyle = [aCell.weiboContentTextView vbo_textStyle];
    UIFont * weiboContentTextFont = [UIFont vbo_preferredFontWithTextStyle:weiboContentTextStyle scale:cellTitleTextScaleFactor];
    
    aCell.weiboContentTextView.font = weiboContentTextFont;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
