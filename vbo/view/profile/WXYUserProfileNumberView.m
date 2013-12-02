//
//  WXYUserProfileNumberView.m
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfileNumberView.h"
#import "WXYSettingManager.h"

@implementation WXYUserProfileNumberView

#pragma mark - Static Method
+ (WXYUserProfileNumberView*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYUserProfileNumberView" bundle:[NSBundle mainBundle]];
    
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    if (array.count)
    {
        return array[0];
    }
    else
    {
        return nil;
    }
}

#pragma mark - Init Method
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.followingNumberLabel.textColor = SHARE_SETTING_MANAGER.themeColor;
    self.followerNumberLabel.textColor = SHARE_SETTING_MANAGER.themeColor;
}
- (void)tintColorDidChange
{
    [super tintColorDidChange];
    self.followingNumberLabel.textColor = SHARE_SETTING_MANAGER.themeColor;
    self.followerNumberLabel.textColor = SHARE_SETTING_MANAGER.themeColor;
}
- (void)layoutSubviews
{
    [super layoutSubviews]; 
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
