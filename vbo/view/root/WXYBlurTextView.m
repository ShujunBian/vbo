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
    
//    NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:_text attributes:@{}];
    
    self.textLayer.string = _text;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.textLayer = [CATextLayer layer];
        
        self.text = @"aaaaaa";
        
        [self refresh];
        
        self.layer.mask = self.textLayer;
        self.textLayer.position = self.center;

//        self.textLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
        
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLayer.frame = self.bounds;
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
