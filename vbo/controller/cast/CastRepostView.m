//
//  CastRepostView.m
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastRepostView.h"
#import "Status.h"
#import "WXYSettingManager.h"
#import "UIImageView+MKNetworkKitAdditions.h"

#define contentLabelLineSpace 6.0
#define repostViewConstantHeight 55
#define backgroundViewColor [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0]

@implementation CastRepostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CastRepostView"
                                                      owner:self
                                                    options:nil];
        self = [nibs objectAtIndex:0];
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setCastRepostViewByStatus:(Status *)currentStatus
{
    if (currentStatus!= nil) {
        _currentRepostStatus = currentStatus;
        
        [_backgroundView setBackgroundColor:backgroundViewColor];
        NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:_currentRepostStatus.text]
                                                                          WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                             withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                            withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                      withLabelLineSpace:contentLabelLineSpace];
        [_repostContentTextView setAttributedText:contentString];
        [_repostContentTextView setScrollEnabled:NO];
        _repostContentTextViewHeightConstraint.constant = [UITextViewHelper HeightForAttributedString:contentString withWidth:288.0f];
        
        if (_currentRepostStatus.bmiddlePicURL != nil) {
            _repostUserNameTopConstraint.constant = 120.0;
            [_repostImageView setImage:nil];
            NSURL *anImageURL = [NSURL URLWithString:_currentRepostStatus.bmiddlePicURL];
            [_repostImageView setImageFromURL:anImageURL placeHolderImage:nil animation:YES completion:nil];
            _repostImageView.contentMode = UIViewContentModeScaleAspectFill;
            _repostImageView.clipsToBounds = YES;
        }
        else {
            _repostUserNameTopConstraint.constant = 22.0;;
        }
    }
    [self setNeedsLayout];
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
    return heightofCastRepostView;
}

- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    calculateAndSetFonts(self);
    _repostContentTextViewHeightConstraint.constant = [UITextViewHelper HeightForAttributedString:_repostContentTextView.attributedText
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
static inline void calculateAndSetFonts(CastRepostView *repostView)
{
    static const CGFloat cellTitleTextScaleFactor = 1;
    
    NSString * weiboContentTextStyle = [repostView.repostContentTextView vbo_textStyle];
    UIFont * weiboContentTextFont = [UIFont vbo_preferredFontWithTextStyle:weiboContentTextStyle scale:cellTitleTextScaleFactor];
    repostView.repostContentTextView.font = weiboContentTextFont;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
