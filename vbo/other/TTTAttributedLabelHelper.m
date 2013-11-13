//
//  TTTAttributedLabelHelper.m
//  vbo
//
//  Created by Emerson on 13-11-13.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "TTTAttributedLabelHelper.h"
#import "TTTAttributedLabel.h"

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


@implementation TTTAttributedLabelHelper

+ (void)theTTTatributedlabel:(TTTAttributedLabel *)label
          setAttributeString:(NSMutableAttributedString *)attributeString
                    withFont:(UIFont *)font
                   withColor:(UIColor *)color
{
    [label setText:attributeString afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        
        NSRange stringRange = NSMakeRange(0, [mutableAttributedString length]);
        NSRegularExpression *regexp = UrlRegularExpression();
        NSRange urlRange = [regexp rangeOfFirstMatchInString:[mutableAttributedString string] options:0 range:stringRange];
        [regexp enumerateMatchesInString:[mutableAttributedString string]
                                 options:0
                                   range:stringRange
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  CTFontRef systemFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
                                  if (systemFont) {
                                      [mutableAttributedString removeAttribute:(NSString *)kCTFontAttributeName range:stringRange];
                                      [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)systemFont range:urlRange];
                                      
                                      [mutableAttributedString removeAttribute:(NSString *)kCTForegroundColorAttributeName range:stringRange];
                                      [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color.CGColor range:urlRange];
                                      CFRelease(systemFont);
                                  }
                              }];
        return mutableAttributedString;
    }];
}

@end
