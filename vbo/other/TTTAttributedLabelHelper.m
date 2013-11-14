//
//  TTTAttributedLabelHelper.m
//  vbo
//
//  Created by Emerson on 13-11-13.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "TTTAttributedLabelHelper.h"
#import "TTTAttributedLabel.h"
#import "WXYSettingManager.h"

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
+ (NSMutableAttributedString* )setAttributeString:(NSMutableAttributedString *)mutableAttributedString
                                   WithNormalFont:(UIFont *)normalFont
                                      withUrlFont:(UIFont *)urlFont
                                  withNormalColor:(UIColor *)normalColor
                                     withUrlColor:(UIColor *)urlColor
                               withLabelLineSpace:(float)lineSpace
{
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    [mutableAttributedString addAttribute:NSFontAttributeName
                                    value:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                    range:stringRange];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpace];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [mutableAttributedString addAttribute:NSParagraphStyleAttributeName
                                    value:style
                                    range:stringRange];
    [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)normalColor.CGColor range:stringRange];
    
    NSRegularExpression *regexp = UrlRegularExpression();
    NSRange urlRange = [regexp rangeOfFirstMatchInString:[mutableAttributedString string] options:0 range:stringRange];
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              CTFontRef urlFontRef = CTFontCreateWithName((__bridge CFStringRef)urlFont.fontName, urlFont.pointSize, NULL);
                              if (urlFontRef) {
                                  [mutableAttributedString removeAttribute:(NSString *)kCTFontAttributeName range:urlRange];
                                  [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)urlFontRef range:urlRange];
                                  
                                  [mutableAttributedString removeAttribute:(NSString *)kCTForegroundColorAttributeName range:urlRange];
                                  [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)urlColor.CGColor range:urlRange];
                                  CFRelease(urlFontRef);
                              }
                          }];
    return mutableAttributedString;
}

+ (float)HeightForAttributedString:(NSAttributedString *)attributedString
                       withPadding:(float)padding
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    CFRange fitRange;
    CFRange textRange = CFRangeMake(0, attributedString.length);
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(288, CGFLOAT_MAX), &fitRange);
    CFRelease(framesetter);
    
    return frameSize.height + padding;
}


@end
