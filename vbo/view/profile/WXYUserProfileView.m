//
//  WXYUserProfileView.m
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfileView.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"


@implementation WXYUserProfileView

+ (WXYUserProfileView*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYUserProfileView" bundle:[NSBundle mainBundle]];
    
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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Bind
- (void)bind:(User*)user
{
    NSURL* url = [NSURL URLWithString:user.avatarLargeUrl];
    [self.headPhotoImageView setImageFromURL:url];
    
    self.follingNumberLabel.text = user.following.stringValue;
    self.followedNumberLabel.text = user.followersCount.stringValue;
    self.genderLabel.text = user.gender;
    self.locationLabel.text = user.location;
    self.descriptionLabel.text = user.userDescription;
    
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
