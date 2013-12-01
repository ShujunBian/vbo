//
//  CastImageViewController.h
//  vbo
//
//  Created by Emerson on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "ViewController.h"

@class CastImageViewController;
@protocol CastImageViewControllerDelegate <NSObject>

-(void) castImageDidDismiss:(CastImageViewController *)viewController;

@end

@interface CastImageViewController : ViewController

@property (nonatomic, strong) UIImageView * weiboDetailImageView;
@property (nonatomic) CGRect initialRect;
@property (nonatomic, weak) id<CastImageViewControllerDelegate> delegate;

@end
