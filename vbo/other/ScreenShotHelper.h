//
//  screenShotHelper.h
//  vbo
//
//  Created by Emerson on 13-11-20.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenShotHelper : NSObject

@property (nonatomic, strong) UIImageView * blurredImageView;
@property (nonatomic, strong) UIImageView * nextBlurredImageView;
@property (nonatomic) NSInteger currentContentOffsetPage;

+ (ScreenShotHelper *)sharedScreenShotHelper;

@end
