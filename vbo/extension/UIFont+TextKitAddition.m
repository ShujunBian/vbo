//
//  UIFont+Addition.m
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "UIFont+TextKitAddition.h"

@implementation UIFont (TextKitAddition)

+ (UIFont *)vbo_preferredFontWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale
{
    UIFontDescriptor *newFontDescriptor = [UIFontDescriptor vbo_preferredFontDescriptorWithTextStyle:aTextStyle scale:aScale];
    
    return [UIFont fontWithDescriptor:newFontDescriptor size:newFontDescriptor.pointSize];
}

- (NSString *)vbo_textStyle
{
    return [self.fontDescriptor vbo_textStyle];
}

- (UIFont *)vbo_fontWithScale:(CGFloat)aScale
{
    return [self fontWithSize:lrint(self.pointSize * aScale)];
}

@end
