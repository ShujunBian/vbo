//
//  WXYNavigationBar.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYNavigationBar.h"


@interface WXYNavigationBar ()

@property (strong, nonatomic) AMBlurView* blurView;

@end


@implementation WXYNavigationBar

#pragma mark - Init Method
- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 65)];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.blurTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        self.titleTextView = [[WXYBlurTextView alloc] init];

        [self addSubview:self.titleTextView];
        
        
        NSDictionary* viewsDict = @{@"outView":self, @"titleTextView":self.titleTextView};
//        NSArray* vLayouts = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleTextView]-|" options:0 metrics:nil views:viewsDict];
//        NSArray* hLayouts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleTextView]|" options:0 metrics:nil views:viewsDict];
        
//        [self addConstraints:vLayouts];
//        [self addConstraints:hLayouts];
        
        
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
