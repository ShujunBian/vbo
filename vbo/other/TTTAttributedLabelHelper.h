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

+ (void)theTTTatributedlabel:(TTTAttributedLabel* ) label
          setAttributeString:(NSMutableAttributedString* ) attributeString
                    withFont:(UIFont* )font
                   withColor:(UIColor* )color;

@end




