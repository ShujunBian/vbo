//
//  WXYBlurTextView.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYBlurTextView.h"


#import <QuartzCore/QuartzCore.h>

@interface WXYBlurTextView ()

@property (strong, nonatomic) CATextLayer* textLayer;

@end

@implementation WXYBlurTextView

#pragma mark - Getter And Setter Method
- (void)setText:(NSString *)text
{
    _text = text;
    self.textLayer.string = _text;
}

#pragma mark - Init Method
- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 65)];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
//        self.blurTintColor = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.5f];
        self.textLayer = [CATextLayer layer];
        self.textLayer.frame = CGRectMake(0, 0, 160, 40);
        [self.textLayer setPosition:self.center];
        self.text = @"aaaaaa";
//        [self.layer addSublayer:self.textLayer];
//        self.layer.mask = self.textLayer;
        
        CGMutablePathRef path = CGPathCreateMutable(); CGPathMoveToPoint(path, NULL, 0, 100);
        
        CGPathAddLineToPoint(path, NULL, 200, 0); CGPathAddLineToPoint(path, NULL, 200, 200); CGPathAddLineToPoint(path, NULL, 0, 100);
        CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
        [shapeLayer setBounds:CGRectMake(0, 0, 200, 200)];
        [shapeLayer setFillColor:[[UIColor purpleColor] CGColor]];
        [shapeLayer setPosition:CGPointMake(200, 200)];
        [shapeLayer setPath:path];

        [self refresh];
//        self.layer.mask = shapeLayer;
//        for (CALayer* layer in self.layer.sublayers)
//        {
//            layer.mask = shapeLayer;
//        }
        
        
        self.layer.mask = self.textLayer;
//        [self.layer addSublayer:shapeLayer];
        
//        self.layer.masksToBounds = YES;
        
//        [self.layer addSublayer:shapeLayer];
        
//        self.layer.masksToBounds = YES;

    }
    return self;
}

- (void)refresh
{

#warning SnapShotImage应该为模糊以后的截图
    UIImage* snapShotImage = [UIImage imageNamed:@"test.png"];
    
    self.layer.contents = (__bridge id)(snapShotImage.CGImage);
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
