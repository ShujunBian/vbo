//
//  WXYUserProfilePhotoCell.m
//  vbo
//
//  Created by wxy325 on 12/2/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfilePhotoView.h"

@implementation WXYUserProfilePhotoView

#pragma mark - Static Method
+ (WXYUserProfilePhotoView*)makeView
{
    UINib* nib = [UINib nibWithNibName:@"WXYUserProfilePhotoView" bundle:[NSBundle mainBundle]];
    
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
    self.headPhotoImageView.layer.masksToBounds = YES;
    self.headPhotoImageView.layer.cornerRadius = self.headPhotoImageView.frame.size.height / 2;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
