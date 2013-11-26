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
#import "MyTextAttachment.h"

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

@implementation UITextViewHelper

+ (NSMutableAttributedString* )setAttributeString:(NSMutableAttributedString *)mutableAttributedString
                                   WithNormalFont:(UIFont *)normalFont
                                      withUrlFont:(UIFont *)urlFont
                                  withNormalColor:(UIColor *)normalColor
                                     withUrlColor:(UIColor *)urlColor
                               withLabelLineSpace:(float)lineSpace
{
    [UITextViewHelper addLinkToAttributedString:mutableAttributedString];

    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpace];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary* scriptAttributes = @{ NSFontAttributeName : normalFont,
                                        NSForegroundColorAttributeName : normalColor,
                                        NSParagraphStyleAttributeName : style
                                        };
    
    [mutableAttributedString addAttributes:scriptAttributes range:stringRange];
    
    
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
                              NSDictionary* nameLinkAttributeDic = @{
                                                                     NSLinkAttributeName: [[[mutableAttributedString string] substringWithRange:result.range]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                                     };
                              [mutableAttributedString addAttributes:nameLinkAttributeDic range:result.range];
                          }];
    
    regexp = TagRegularExpression();
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              NSDictionary* tagLinkAttributeDic = @{NSLinkAttributeName: [[[mutableAttributedString string] substringWithRange:result.range]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};                              [mutableAttributedString addAttributes:tagLinkAttributeDic range:result.range];
                          }];
    
    regexp = UrlRegularExpression();
    [regexp enumerateMatchesInString:[mutableAttributedString string]
                             options:0
                               range:stringRange
                          usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                              NSDictionary* urlLinkAttributeDic = @{NSLinkAttributeName: [[[mutableAttributedString string] substringWithRange:result.range]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
                              [mutableAttributedString addAttributes:urlLinkAttributeDic range:result.range];
                          }];
    
    
    regexp = EmotionRegularExpression();
    NSRange emotionStringRange = NSMakeRange(0, mutableAttributedString.length);

    NSTextCheckingResult *result = [regexp firstMatchInString:[mutableAttributedString string]
                                                      options:0
                                                        range:emotionStringRange];
    while (result) {
        NSRange keyRange = NSMakeRange(result.range.location + 1, result.range.length - 2);
        NSString * keyString = [[mutableAttributedString string] substringWithRange:keyRange];
        
        MyTextAttachment * myTextAttachment = [[MyTextAttachment alloc]initWithData:nil ofType:nil];
        if ([myTextAttachment insertTextAttachmentIntoAttributedString:mutableAttributedString
                                                                andKey:keyString
                                                               inRange:result.range]) {
            emotionStringRange = NSMakeRange(0, mutableAttributedString.length);
        }
        else {
            emotionStringRange = NSMakeRange(result.range.location + result.range.length - 1,
                                             mutableAttributedString.length - (result.range.location + result.range.length - 1));
        }
        
        result = [regexp firstMatchInString:[mutableAttributedString string]
                                    options:0
                                      range:emotionStringRange];
    }
    
    
    
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
