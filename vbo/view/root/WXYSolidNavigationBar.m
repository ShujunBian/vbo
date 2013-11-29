//
//  WXYSolidNavigationBar.m
//  vbo
//
//  Created by wxy325 on 11/29/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYSolidNavigationBar.h"

@interface WXYSolidNavigationBar ()



@end

@implementation WXYSolidNavigationBar

#pragma mark - Getter And Setter Method
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor colorWithRed:49.f/255.f green:42.f/255.f blue:37.f/255.f alpha:1.f];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:17.f];
        self.titleLabel.textColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];

        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:ROOT_NAV_BAR_LONG_HEIGHT];
        [self addConstraint:self.heightConstraint];
        
        NSLayoutConstraint* centerConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
        [self addConstraint:centerConstraint];
        
        NSLayoutConstraint* vCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:5.f];
        [self addConstraint:vCenterY];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
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
