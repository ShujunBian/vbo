//
//  WXYUserProfileView.h
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface WXYUserProfileView : UIView

@property (strong, nonatomic) IBOutlet NSLayoutConstraint* topAreaHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint* bottomAreaHeightConstraint;


@property (weak, nonatomic) IBOutlet UIImageView* headPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel* follingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* followedNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* genderLabel;
@property (weak, nonatomic) IBOutlet UILabel* locationLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptionLabel;

+ (WXYUserProfileView*)makeView;

- (void)bind:(User*)user;


@end
