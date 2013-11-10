//
//  WXYTabBarPostButton.m
//  vbo
//
//  Created by wxy325 on 11/10/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTabBarPostButton.h"
#import "WXYTabBar.h"
#import "WXYSettingManager.h"
#import "GraphicName.h"

@interface WXYTabBarPostButton ()

@property (strong, nonatomic) UIImage* iconImage;
@property (strong, nonatomic) UIImageView* iconImageView;

@end

@implementation WXYTabBarPostButton
#pragma mark - Getter And Setter Method
- (UIImageView*)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImageView;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:ROOT_TAB_BAR_HEIGHT];
//        NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:[UIScreen mainScreen].bounds.size.width / 5];
        [self addConstraint:heightConstraint];
//        [self addConstraint:widthConstraint];
        
        self.backgroundColor = SHARE_SETTING_MANAGER.themeColor;
        
        self.iconImage = [[UIImage imageNamed:GRAPHIC_TAB_BAR_POST_BUTTON] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.iconImageView.image = self.iconImage;
        [self addSubview:self.iconImageView];
        
        NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint* centerY = [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self addConstraint:centerX];
        [self addConstraint:centerY];
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
