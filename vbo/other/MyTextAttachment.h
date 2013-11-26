//
//  MyTextAttachment.h
//  vbo
//
//  Created by Emerson on 13-11-25.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextAttachment : NSTextAttachment

- (void)setImageByTheKey:(NSString *)key;

- (BOOL)insertTextAttachmentIntoAttributedString:(NSMutableAttributedString *)mutableAttributedString
                                          andKey:(NSString *)keyString
                                         inRange:(NSRange)range;
@end
