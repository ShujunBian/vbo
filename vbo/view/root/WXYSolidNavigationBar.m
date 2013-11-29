//
//  WXYSolidNavigationBar.m
//  vbo
//
//  Created by wxy325 on 11/29/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYSolidNavigationBar.h"

#define FONT_SIZE_SMALL 12.f
#define FONT_SIZE_LARGE 17.f

@interface WXYSolidNavigationBar ()

@property (strong, nonatomic) NSLayoutConstraint* heightConstraint;

@end

@implementation WXYSolidNavigationBar
@dynamic navBarHeight;

#pragma mark - Getter And Setter Method
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}
- (float)navBarHeight
{
    return self.heightConstraint.constant;
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
#pragma mark - Change Height
- (void)changeNavBarHeightBy:(float)deltaHeight
{
    float preHeight = self.heightConstraint.constant;
    float height = deltaHeight + preHeight;
    [self changeNavBarHeightTo:height];
}
- (void)changeNavBarHeightTo:(float)height
{
    height = height < ROOT_NAV_BAR_SHORT_HEIGHT? ROOT_NAV_BAR_SHORT_HEIGHT : height;
    height = height > ROOT_NAV_BAR_LONG_HEIGHT? ROOT_NAV_BAR_LONG_HEIGHT : height;
    self.heightConstraint.constant = height;
    
    float ratio = (height - ROOT_NAV_BAR_SHORT_HEIGHT) / (ROOT_NAV_BAR_LONG_HEIGHT - ROOT_NAV_BAR_SHORT_HEIGHT);

#warning 还未改变文字大小及隐藏图标
#warning 为显示缩小动画，字体使用scale调小
    self.titleLabel.transform = CGAffineTransformMakeScale(0.7f + 0.3*ratio, 0.7f + 0.3*ratio);
}


@end
