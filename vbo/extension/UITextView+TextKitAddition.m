//
//  UITextView+TextKitAddition.m
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "UITextView+TextKitAddition.h"

@implementation UITextView (TextKitAddition)

- (NSString *)vbo_textStyle
{
    return [self.font vbo_textStyle];
}

@end
