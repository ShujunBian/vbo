//
//  WXYTabBarButton.m
//  vbo
//
//  Created by wxy325 on 11/9/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTabBarButton.h"
#import "WXYTabBar.h"


@interface WXYTabBarButton ()

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIImage* iconImage;
@property (strong, nonatomic) UIImageView* iconImageView;

@end

@implementation WXYTabBarButton

#pragma mark - Getter And Setter Method
- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10.f];
    }
    return _titleLabel;
}
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
- (id)initWithImageName:(NSString*)imageName title:(NSString*)title
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        
        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:ROOT_TAB_BAR_HEIGHT];
        NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:[UIScreen mainScreen].bounds.size.width / 5];
        [self addConstraint:heightConstraint];
        [self addConstraint:widthConstraint];
        
    
        self.iconImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.iconImageView.image = self.iconImage;
        self.titleLabel.text = title;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        
        NSArray* positionConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[icon]-4-[title(10)]-3-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"icon": self.iconImageView,@"title":self.titleLabel}];
        NSLayoutConstraint* centerX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        [self addConstraints:positionConstraints];
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
