//
//  WXYUserProfilePhotoCell.h
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYUserProfilePhotoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView* headPhotoImageView;

+ (WXYUserProfilePhotoView*)makeView;

@end
