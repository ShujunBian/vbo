//
//  MyTextAttachment.m
//  vbo
//
//  Created by Emerson on 13-11-25.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "MyTextAttachment.h"
#import "EmoticonsInfoHelper.h"

static MyTextAttachment * sharedMyTextAttachment;

@implementation MyTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer
                      proposedLineFragment:(CGRect)lineFrag
                             glyphPosition:(CGPoint)position
                            characterIndex:(NSUInteger)charIndex
{
    NSLog(@"the lineFrag is %f %f",lineFrag.size.width,lineFrag.size.height);
    return CGRectMake( 0 , -3.0 , lineFrag.size.height , lineFrag.size.height );
}

- (void)setImageByTheKey:(NSString *)key
{
    EmoticonsInfoHelper * emoticonsInfoHelper = [EmoticonsInfoHelper sharedEmoticonsInfoHelper];
    EmoticonsInfo * emoticonsInfo = [emoticonsInfoHelper emoticonsInfoForKey:key];
    if (emoticonsInfo != nil) {
        [self setImage:[UIImage imageNamed:emoticonsInfo.imageFileName]];
    }
}

- (BOOL)insertTextAttachmentIntoAttributedString:(NSMutableAttributedString *)mutableAttributedString
                                          andKey:(NSString *)keyString
                                         inRange:(NSRange)range
{
    [self setImageByTheKey:keyString];
    if (self.image != nil) {
        NSAttributedString * textAttachmentString = [ NSAttributedString attributedStringWithAttachment:self ] ;
        [mutableAttributedString insertAttributedString:textAttachmentString atIndex:range.location];
        
        NSRange blankRange = NSMakeRange(range.location + 1, range.length);
        NSAttributedString * blankString = [[NSAttributedString alloc]initWithString:@""];
        [mutableAttributedString replaceCharactersInRange:blankRange withAttributedString:blankString];
        
        return YES;
    }
    return NO;
}

@end

