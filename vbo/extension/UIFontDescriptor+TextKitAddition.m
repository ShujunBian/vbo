//
//  UIFontDescriptor+Addition.m
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "UIFontDescriptor+TextKitAddition.h"

@implementation UIFontDescriptor (TextKitAddition)
+ (UIFontDescriptor *)vbo_preferredFontDescriptorWithTextStyle:(NSString *)aTextStyle scale:(CGFloat)aScale
{
    UIFontDescriptor *newBaseDescriptor = [self preferredFontDescriptorWithTextStyle:aTextStyle];
    
    return [newBaseDescriptor fontDescriptorWithSize:lrint([newBaseDescriptor pointSize] * aScale)];
}

- (NSString *)vbo_textStyle
{
    return [self objectForKey:@"NSCTFontUIUsageAttribute"];
}

- (UIFontDescriptor *)vbo_fontDescriptorWithScale:(CGFloat)aScale
{
    return [self fontDescriptorWithSize:lrint(self.pointSize * aScale)];
}

@end
