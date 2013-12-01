//
//  WXYTabBarButton.m
//  vbo
//
//  Created by wxy325 on 11/9/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTabBarSolidButton.h"
#import "WXYSolidTabBar.h"
#import "WXYSettingManager.h"
#define TEXT_COLOR [UIColor colorWithRed:146.f/255.f green:146.f/255.f blue:146.f/255.f alpha:1.f];
#define IMAGE_VIEW_TINT_COLOR_NORMAL [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f]


@interface WXYTabBarSolidButton ()

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIImage* iconImage;
@property (strong, nonatomic) UIImage* iconImageHighlight;
@property (strong, nonatomic) UIImageView* iconImageView;

@end

@implementation WXYTabBarSolidButton

#pragma mark - Getter And Setter Method
- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10.f];
        _titleLabel.textColor = TEXT_COLOR;
    }
    return _titleLabel;
}
- (UIImageView*)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconImageView.tintColor = IMAGE_VIEW_TINT_COLOR_NORMAL;
    }
    return _iconImageView;
}
- (void)setHighlight:(BOOL)highlight
{
    _highlight = highlight;
    if (_highlight)
    {
        self.iconImageView.image = self.iconImageHighlight;
        self.iconImageView.tintColor = nil;
        self.titleLabel.textColor = SHARE_SETTING_MANAGER.themeColor;
    }
    else
    {
        self.iconImageView.image = self.iconImage;
        self.iconImageView.tintColor = IMAGE_VIEW_TINT_COLOR_NORMAL;
        self.titleLabel.textColor = TEXT_COLOR;
    }
}

#pragma mark - Init Method
- (id)initWithImageName:(NSString*)imageName highlightImageName:(NSString*)highlightImageName title:(NSString*)title;
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _highlight = NO;
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:ROOT_TAB_BAR_HEIGHT];
//        NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:[UIScreen mainScreen].bounds.size.width / 5];
        [self addConstraint:heightConstraint];
//        [self addConstraint:widthConstraint];
        
    
        self.iconImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.iconImageHighlight = [[UIImage imageNamed:highlightImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.iconImageView.image = self.iconImage;
        self.titleLabel.text = title;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        
        NSLayoutConstraint* iconCenterX = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
        NSLayoutConstraint* iconCenterY = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:-5];

        NSLayoutConstraint* labelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
        NSLayoutConstraint* labelBottomY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:-3.f];
        
        
//        NSArray* positionConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[icon]-4-[title(10)]-3-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"icon": self.iconImageView,@"title":self.titleLabel}];
        NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//        [self addConstraints:positionConstraints];
        [self addConstraint:labelCenterX];
        [self addConstraint:labelBottomY];
        [self addConstraint:iconCenterX];
        [self addConstraint:iconCenterY];
        [self addConstraint:centerX];
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
