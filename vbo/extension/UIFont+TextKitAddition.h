//
//  UIFont+Addition.h
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TextKitAddition)

+ (UIFont *)vbo_preferredFontWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale;

- (NSString *)vbo_textStyle;
- (UIFont *)vbo_fontWithScale:(CGFloat)fontScale;

@end
