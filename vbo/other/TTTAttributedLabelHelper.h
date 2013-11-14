//
//  TTTAttributedLabelHelper.h
//  vbo
//
//  Created by Emerson on 13-11-13.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTAttributedLabel;
@interface TTTAttributedLabelHelper : NSObject

/*! 设置TTTAttributedLabel所有属性
 * \param attributeString 传入要设置的attributeString
 * \param normalFont 常规文字的字体
 * \param urlFont url文字的字体
 * \param normalColor 常规文字的颜色
 * \param urlColor url文字的颜色
 */

+ (NSMutableAttributedString* )setAttributeString:(NSMutableAttributedString* )mutableAttributedString
                                   WithNormalFont:(UIFont* )normalFont
                                      withUrlFont:(UIFont* )urlFont
                                  withNormalColor:(UIColor* )normalColor
                                     withUrlColor:(UIColor* )urlColor
                               withLabelLineSpace:(float) lineSpace;

/*! 获取AttributedSting的高度
 * \param attributedString 被设置的attributedString
 * \param padding attributedString 的空白
 * \returns attributedString高度
 */
+ (float)HeightForAttributedString:(NSAttributedString *)attributedString
                       withPadding:(float)padding;
@end




