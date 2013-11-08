//
//  WXYNavigationBar.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYNavigationBar.h"
#import "WXYBlurTextView.h"

@interface WXYNavigationBar ()

@property (strong, nonatomic) AMBlurView* blurView;

@property (strong, nonatomic) WXYBlurTextView* titleTextView;


@end

@implementation WXYNavigationBar
@dynamic snapShotView;
- (void)setSnapShotView:(UIView *)snapShotView
{
    self.titleTextView.snapShotView = snapShotView;
}
- (UIView*)snapShotView
{
    return self.titleTextView.snapShotView;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.blurTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        self.titleTextView = [[WXYBlurTextView alloc] init];

        [self addSubview:self.titleTextView];
     
        self.navBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:65.f];
        [self addConstraint:self.navBarHeightConstraint];
        
        NSDictionary* viewsDict = @{@"outView":self, @"titleTextView":self.titleTextView};
        NSArray* vLayouts = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleTextView]|" options:0 metrics:nil views:viewsDict];
        NSArray* hLayouts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleTextView]|" options:0 metrics:nil views:viewsDict];
        [self addConstraints:vLayouts];
        [self addConstraints:hLayouts];
    }
    return self;
}

- (void)refresh
{
    [self.titleTextView refresh];
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
