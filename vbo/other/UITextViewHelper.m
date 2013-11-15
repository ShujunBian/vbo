//
//  UITextViewHelper.m
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "UITextViewHelper.h"
#import "WXYSettingManager.h"
#import <CoreText/CoreText.h>

static NSRegularExpression *__nameRegularExpression;
static inline NSRegularExpression * NameRegularExpression() {
    if (!__nameRegularExpression) {
        __nameRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"@[[a-z][A-Z][0-9][\\u4E00-\\u9FA5]-_]*" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return __nameRegularExpression;
}

static NSRegularExpression *__tagRegularExpression;
static inline NSRegularExpression * TagRegularExpression() {
    if (!__tagRegularExpression) {
        __tagRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"[#＃]{1}[^\\[\\]#＃]+[#＃]{1}" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return __tagRegularExpression;
}

static NSRegularExpression *__urlRegularExpression;
static inline NSRegularExpression * UrlRegularExpression() {
    if (!__urlRegularExpression) {
        __urlRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"https?://[[a-z][A-Z][0-9]\?/%&=.]+" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return __urlRegularExpression;
}

static NSRegularExpression *__emotionRegularExpression;
static inline NSRegularExpression * EmotionRegularExpression() {
    if (!__emotionRegularExpression) {
        __emotionRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"\\[[[\\u4E00-\\u9FA5][a-z]]*\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return __emotionRegularExpression;
}

static NSRegularExpression *__emotionIDRegularExpression;
static inline NSRegularExpression * EmotionIDRegularExpression() {
    if (!__emotionIDRegularExpression) {
        __emotionIDRegularExpression = [[NSRegularExpression alloc] initWithPattern:@" \\[[[a-f][0-9] ]*\\] " options:NSRegularExpressionCaseInsensitive error:nil];
    }
    
    return __emotionIDRegularExpression;
}

@implementation UITextViewHelper

+ (NSMutableAttributedString* )setAttributeString:(NSMutableAttributedString *)mutableAttributedString
                                   WithNormalFont:(UIFont *)normalFont
                                      withUrlFont:(UIFont *)urlFont
                                  withNormalColor:(UIColor *)normalColor
                                     withUrlColor:(UIColor *)urlColor
                               withLabelLineSpace:(float)lineSpace
{
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpace];
    [style setLineBreakMode:NSLineBreakByWordWrapping];

    NSDictionary* scriptAttributes = @{ NSFontAttributeName : normalFont,
                                        NSForegroundColorAttributeName : normalColor,
                                        NSParagraphStyleAttributeName : style
                                        };
    
    [mutableAttributedString addAttributes:scriptAttributes range:stringRange];
    
    [UITextViewHelper addLinkToAttributedString:mutableAttributedString];
    
    return mutableAttributedString;
}

+ (void)addLinkToAttributedString:(NSMutableAttributedString *)mutableAttributedString
{
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSRegularExpression *regexp = NameRegularExpression();
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              
                              NSDictionary* nameLinkAttributeDic = @{NSLinkAttributeName: @"nameLink"};
                              [mutableAttributedString addAttributes:nameLinkAttributeDic range:result.range];
                          }];
    
    regexp = TagRegularExpression();
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              
                              NSDictionary* tagLinkAttributeDic = @{NSLinkAttributeName: @"tagLink"};
                              [mutableAttributedString addAttributes:tagLinkAttributeDic range:result.range];
                          }];

    
    regexp = UrlRegularExpression();
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              
                              NSDictionary* urlLinkAttributeDic = @{NSLinkAttributeName: @"urlLink"};
                              [mutableAttributedString addAttributes:urlLinkAttributeDic range:result.range];
                          }];


}

+ (float)HeightForAttributedString:(NSAttributedString *)attributedString
                         withWidth:(float)width
{
    UITextView * testView = [[UITextView alloc]init];
    testView.attributedText = attributedString;
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize requiredSize = [testView sizeThatFits:maxSize];
    return requiredSize.height;
}

@end
