//
//  CVDragIndicator.m
//  vbo
//
//  Created by Emerson on 13-11-30.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CVDragIndicatorView.h"
#define DEGREETORADIANS  3.1415926 / 180.0

@implementation CVDragIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [SHARE_SETTING_MANAGER.themeColor CGColor]);
    UIBezierPath* aPath;
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(160.0, 22.0)
                                               radius:10.0
                                           startAngle:45.0 * DEGREETORADIANS
                                             endAngle:135.0 * DEGREETORADIANS
                                            clockwise:NO];
    aPath.lineWidth = 1.0;
    [aPath stroke];
    CGContextStrokePath(context);
}


@end
