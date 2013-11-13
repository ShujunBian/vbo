//
//  WXYBarButtonAbstract.h
//  vbo
//
//  Created by wxy325 on 11/11/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYBarButtonAbstract : UIView

- (id)init;

- (void)addTarget:(id)target selector:(SEL)selector;

@end
