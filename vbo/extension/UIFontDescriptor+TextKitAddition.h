//
//  UIFontDescriptor+Addition.h
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFontDescriptor (TextKitAddition)

+ (UIFontDescriptor *)vbo_preferredFontDescriptorWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale;

- (NSString *)vbo_textStyle;
- (UIFontDescriptor *)vbo_fontDescriptorWithScale:(CGFloat)aScale;

@end
