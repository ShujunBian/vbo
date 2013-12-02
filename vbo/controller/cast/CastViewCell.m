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
#import "ComRepViewController.h"
#import "NSDate+Addition.h"

#define padding 5.0
#define weiboImageHeight 180.0
#define weiboCellBetweenHeight 10.0
#define repostViewConstantHeight 59.0
#define contentLabelLineSpace 6.0
#define repostBackgroundViewColor [UIColor colorWithRed:234.0 / 255.0 green:234.0 / 255.0 blue:234.0 / 255.0 alpha:1.0]
#define shadowHeight 1.0

@interface CastViewCell()<UITextViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) Status * currentStatus;

@property (nonatomic, weak) IBOutlet UIImageView * weiboImage;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * weiboImageHeightConstaint;
@property (nonatomic, weak) IBOutlet UIImageView * userAvator;

@property (nonatomic, weak) IBOutlet UILabel * userNickname;
@property (nonatomic, weak) IBOutlet UILabel * commentTimesLabel;
@property (nonatomic, weak) IBOutlet UILabel * repostTimesLabel;
@property (nonatomic, weak) IBOutlet UILabel * currentTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * avatorTopSpaceConstaint;

@property (weak, nonatomic) IBOutlet UIView * cellBackgroundView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * cellBackgroundViewBottomConstraint;

@property (nonatomic, weak) IBOutlet UIButton * moreButton;
@property (nonatomic, weak) IBOutlet UIButton * commentButton;
@property (nonatomic, weak) IBOutlet UIButton * repostButton;

@property (nonatomic, weak) IBOutlet UITextView * weiboContentTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * contentTextViewHegihtConstraint;

@property (nonatomic, weak) IBOutlet UIImageView * repostImageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostImageHeightConstaint;
@property (nonatomic, weak) IBOutlet UITextView * repostTextView;
@property (nonatomic, weak) IBOutlet UILabel * repostUserNameLabel;
@property (nonatomic, weak) IBOutlet UIView * repostBackgroundView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostTextViewHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * reposetUserNameTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostButtonTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostBackgroundViewConstraint;

@property (nonatomic, weak) IBOutlet UIImageView * shadowImageView;

//@property (nonatomic, strong) CastRepostView * repostContentView;
@end

@implementation CastViewCell
{
    UITapGestureRecognizer * tapGesture;
}

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
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    
    //    [self prepareGestureRecognizerInView:self];
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
    //    if (selected) {
    //        [_cellBackgroundView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor];
    //        [_weiboContentTextView setTextColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];
    //    }
}

#pragma mark - 设置castview点击后效果
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    if (highlighted) {
////        [UIView animateWithDuration:0.3 animations:^{
//            [_cellBackgroundView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor];
//            [_weiboContentTextView setTextColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];
//
////        }completion:nil];
//
//    }
//    else  {
//        [UIView animateWithDuration:0.3 animations:^{
//            [_cellBackgroundView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];
//            [_weiboContentTextView setTextColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor];
//
//        }completion:nil];
//
//    }
//}

- (void)setCellWithWeiboStatus:(Status *)currentCellStatus
                  isInCastView:(BOOL)isInCastView
{
    self.currentStatus = currentCellStatus;
    
    [_cellBackgroundView setBackgroundColor:SHARE_SETTING_MANAGER.castViewTableCellBackgroundColor];
    _cellBackgroundViewBottomConstraint.constant = isInCastView ? 5.0 : 1.0;
    
    [_weiboContentTextView setAttributedText:[self weiboContentLabelAttributedStringByStatus:currentCellStatus]];
    _contentTextViewHegihtConstraint.constant = [UITextViewHelper HeightForAttributedString:_weiboContentTextView.attributedText
                                                                                  withWidth:288.0];
    [_weiboContentTextView setScrollEnabled:NO];
    _weiboContentTextView.delegate = self;
    
    [_weiboImage setImage:nil];
    [_weiboImage removeGestureRecognizer:tapGesture];
    if (currentCellStatus.bmiddlePicURL != nil) {
        _weiboImageHeightConstaint.constant = 180.0;
        _avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
        NSURL *anImageURL = [NSURL URLWithString:currentCellStatus.bmiddlePicURL];
        [_weiboImage setImageFromURL:anImageURL placeHolderImage:nil animation:YES completion:nil];
        _weiboImage.contentMode = UIViewContentModeScaleAspectFill;
        _weiboImage.clipsToBounds = YES;
        [self prepareGestureRecognizerInView:_weiboImage];
    }
    else {
        _weiboImageHeightConstaint.constant = 0.0;
        _avatorTopSpaceConstaint.constant = weiboCellBetweenHeight;
    }
    
    
    [_userAvator setImage:nil];
    [_userAvator setImageFromURLString:currentCellStatus.author.profileImageUrl
                      placeHolderImage:nil animation:YES completion:nil];
    _userAvator.layer.cornerRadius = 16.0;
    _userAvator.layer.masksToBounds = YES;
    
    [_userNickname setText:currentCellStatus.author.screenName];
    [_userNickname setTextColor:SHARE_SETTING_MANAGER.themeColor];
    
    [_currentTimeLabel setTextColor:SHARE_SETTING_MANAGER.castViewTableCellTimeLabelColor];
    [_currentTimeLabel setText:[currentCellStatus.createdAt customString]];
    
    if (isInCastView) {
        _moreButton.imageView.image = [_moreButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_moreButton.imageView setTintColor:SHARE_SETTING_MANAGER.themeColor];
        
        [_commentTimesLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
        NSString * commentTimesString = [NSString stringWithFormat:@"%d",[currentCellStatus.commentsCount integerValue]];
        [_commentTimesLabel setText:commentTimesString];
        [_repostTimesLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
        NSString * repostTimesString = [NSString stringWithFormat:@"%d",[currentCellStatus.repostsCount integerValue]];
        [_repostTimesLabel setText:repostTimesString];
    }
    else {
        _moreButton.hidden = YES;
        _commentButton.hidden = YES;
        _commentTimesLabel.hidden = YES;
        _repostButton.hidden = YES;
        _repostTimesLabel.hidden = YES;
    }
    
    [_repostImageView setImage:nil];
    [_repostImageView removeGestureRecognizer:tapGesture];
    [_repostTextView setText:nil];
    [_repostUserNameLabel setText:nil];
    
    if (currentCellStatus.repostStatus != nil) {
        _repostImageHeightConstaint.constant = 98.0;
        float repostHeightWithPadding = [CastViewCell getHeightofCastRepostViewByStatus:currentCellStatus.repostStatus];
        _repostBackgroundViewConstraint.constant = isInCastView ?  repostHeightWithPadding : repostHeightWithPadding - padding;
        [_repostBackgroundView setBackgroundColor:repostBackgroundViewColor];
        _repostButtonTopConstraint.constant = isInCastView ? [CastViewCell getHeightofCastRepostViewByStatus:currentCellStatus.repostStatus] + 20.0 : 0.0;
        if (currentCellStatus.repostStatus.bmiddlePicURL != nil) {
            _reposetUserNameTopConstraint.constant = 139.0;
            NSURL *anImageURL = [NSURL URLWithString:currentCellStatus.repostStatus.bmiddlePicURL];
            [_repostImageView setImageFromURL:anImageURL placeHolderImage:nil animation:YES completion:nil];
            _repostImageView.contentMode = UIViewContentModeScaleAspectFill;
            _repostImageView.clipsToBounds = YES;
            [self prepareGestureRecognizerInView:_repostImageView];
        }
        else {
            _repostImageHeightConstaint.constant = 0.0;
            _reposetUserNameTopConstraint.constant = 27.0;
        }
        [_repostUserNameLabel setText:currentCellStatus.repostStatus.author.name];
        
        [_repostTextView setAttributedText:[self weiboContentLabelAttributedStringByStatus:currentCellStatus.repostStatus]];
        _repostTextViewHeightConstraint.constant = [UITextViewHelper HeightForAttributedString:_repostTextView.attributedText
                                                                                     withWidth:288.0];
        [_repostTextView setScrollEnabled:NO];
        _repostTextView.delegate = self;
        
    }
    else {
        _repostBackgroundViewConstraint.constant = 0;
        _repostButtonTopConstraint.constant = 0;
    }
    
    UIImage * shadowImage = [UIImage imageNamed:@"card_shadow_unit.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [shadowImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_shadowImageView setImage:shadowImage];
    
    //    NSLog(@"The repostView size is %f %f",tmpCustomView.bounds.size.width,tmpCustomView.bounds.size.height);
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

+ (float)getHeightofCastRepostViewByStatus:(Status *) status
{
    float heightofCastRepostView = repostViewConstantHeight;
    if (status.bmiddlePicURL != nil) {
        heightofCastRepostView += 98.0;
    }
    if (status.text != nil) {
        NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:status.text]
                                                                          WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                             withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                            withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                      withLabelLineSpace:contentLabelLineSpace];
        heightofCastRepostView += [UITextViewHelper HeightForAttributedString:contentString withWidth:288.0f];
    }
    return heightofCastRepostView + padding;
}

#pragma mark - textViewDelegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //    NSLog(@"THE URL IS %@ and The range is %d",URL,characterRange.length);
    NSString * string = [URL.relativeString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"The URL is %@",string);
    
    UIActionSheet * testActionSheet = [[UIActionSheet alloc]initWithTitle:@"Click URl"
                                                                 delegate:self
                                                        cancelButtonTitle:@"OK"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
    [testActionSheet showInView:self.superview];
    //    NSLayoutManager * layoutManger = _weiboContentTextView.layoutManager;
    
    return NO;
}

#pragma mark - IBActions
- (IBAction)clickCommentButton:(id)sender {
    [self.delegateForCastViewCell clickCommentButtonByStatus:_currentStatus];
}

- (IBAction)clickRepostButton:(id)sender {
    [self.delegateForCastViewCell clickRepostButtonByStatus:_currentStatus];
}


#pragma mark - 根据系统设置字体调整cell高度和cell字体大小
static inline void calculateAndSetFonts(CastViewCell *aCell)
{
    static const CGFloat cellTitleTextScaleFactor = 1;
    
    NSString * weiboContentTextStyle = [aCell.weiboContentTextView vbo_textStyle];
    UIFont * weiboContentTextFont = [UIFont vbo_preferredFontWithTextStyle:weiboContentTextStyle scale:cellTitleTextScaleFactor];
    
    aCell.weiboContentTextView.font = weiboContentTextFont;
}
#pragma mark - 初始化手势检测

- (void)prepareGestureRecognizerInView:(UIView *)view{
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:tapGesture];
}

#pragma mark - 手势检测处理
- (void)handleGesture:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint tapPoint = [gestureRecognizer locationInView:self];
    
    CGRect cellRect = self.frame;
    if (_currentStatus.bmiddlePicURL != nil && tapPoint.y < 180.0) {
        CGRect initialRect = _weiboImage.frame;
        initialRect.origin.y += cellRect.origin.y;
        [self.delegateForCastViewCell presentDetailImageViewWithImageView:_weiboImage
                                                       withInitalRect:initialRect];
    }
    else {
        CGRect initialRect = _repostImageView.frame;
        initialRect.origin.y += cellRect.origin.y;
        [self.delegateForCastViewCell presentDetailImageViewWithImageView:_repostImageView
                                                       withInitalRect:initialRect];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
