//
//  WXYBlurTextView.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBlurView.h"

@interface WXYBlurTextView : UIView

@property (copy, nonatomic) NSString* text;
@property (weak, nonatomic) UIView* snapShotView;

- (void)refresh;
@end
