//
//  WXYUserProfileNumberView.h
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXYUserProfileNumberViewDelegate <NSObject>

- (void)followingButtonPressed;
- (void)followerButtonPressed;

@end

@interface WXYUserProfileNumberView : UIView

@property (weak, nonatomic) IBOutlet UILabel* followingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* followerNumberLabel;

+ (WXYUserProfileNumberView*)makeView;
@end
