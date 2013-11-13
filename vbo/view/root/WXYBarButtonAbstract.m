//
//  WXYBarButtonAbstract.m
//  vbo
//
//  Created by wxy325 on 11/11/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYBarButtonAbstract.h"

@interface WXYBarButtonAbstract ()

@end


@implementation WXYBarButtonAbstract

#pragma mark - Init Mehthod
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - Gesture
- (void)addTarget:(id)target selector:(SEL)selector
{
    if (target && selector)
    {
        UIGestureRecognizer* ges = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        [self addGestureRecognizer:ges];
    }
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
