//
//  WXYBlurTextView.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYBlurTextView.h"
#import "UIImage+ImageEffects.h"
#import "NSNotificationCenter+Addition.h"
#import "User.h"

#import <QuartzCore/QuartzCore.h>

@interface WXYBlurTextView ()

@property (strong, nonatomic) UILabel* titleLabel;
@end

@implementation WXYBlurTextView

#pragma mark - Getter And Setter Method
- (void)setText:(NSString *)text
{
    _text = text;
    self.titleLabel.text = _text;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
//        self.textLayer = [CATextLayer layer];
        self.titleLabel = [[UILabel alloc] init];
        self.text = @"";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.mask = self.titleLabel.layer;
        
        [NSNotificationCenter registerDidFetchCurrentUserNameNotificationWithSelector:@selector(afterDidFetchCurrentUserName) target:self];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 20, self.bounds.size.width, self.bounds.size.height - 20);
}

- (void)refresh
{
    if (self.snapShotView)
    {
//        [self setNeedsDisplay];
    }
}

- (void)afterDidFetchCurrentUserName
{
    if (self.snapShotView)
    {
#warning 此处填上现在用户的用户名
        self.text = @"Emersonwade";
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.snapShotView)
    {
        UIGraphicsBeginImageContext(self.frame.size); //currentView 当前的view
        [self.snapShotView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapShotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [snapShotImage applyLightEffect];
        [snapShotImage drawAtPoint:CGPointZero];
    }

}
//- (UIImage *)captureView:(UIView *)view frame:(CGRect)rect
//{
//    CGRect screenRect = rect;
//    UIGraphicsBeginImageContext(screenRect.size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [[UIColor blackColor] set];
//    CGContextFillRect(ctx, screenRect);
//    [view.layer renderInContext:ctx];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    ctx = nil;
//    
//    return newImage;
//}


@end
