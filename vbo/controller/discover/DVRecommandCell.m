//
//  DVRecommandCell.m
//  vbo
//
//  Created by Emerson on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "DVRecommandCell.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"

#define kRecommandCellTextColor [UIColor colorWithRed:150.0 / 255.0 green:150.0 / 255.0 blue:150.0 / 255.0 alpha:1.0]

@interface DVRecommandCell()

@property (nonatomic, weak) IBOutlet UIImageView * shadowLineImageView;
@property (nonatomic, weak) IBOutlet UIImageView * recommandUserAvator1;
@property (nonatomic, weak) IBOutlet UIImageView * recommandUserAvator2;
@property (nonatomic, weak) IBOutlet UIImageView * recommandUserAvator3;
@property (nonatomic, weak) IBOutlet UIImageView * recommandUserAvator4;

@property (nonatomic, weak) IBOutlet UILabel * recommandTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * recommandUserNameLabel1;
@property (nonatomic, weak) IBOutlet UILabel * recommandUserNameLabel2;
@property (nonatomic, weak) IBOutlet UILabel * recommandUserNameLabel3;
@property (nonatomic, weak) IBOutlet UILabel * recommandUserNameLabel4;

@property (nonatomic, weak) IBOutlet UIButton * moreButton;

@end

@implementation DVRecommandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    [self.contentView setBackgroundColor:[UIColor colorWithRed:246.0 / 255.0 green:244.0 / 255.0 blue:240.0 / 255.0 alpha:1.0]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setRecommandCellByUserArray:(NSArray *)userArray
{
    _moreButton.imageView.image = [_moreButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_moreButton setTintColor:kRecommandCellTextColor];
    [_recommandTitleLabel setTextColor:SHARE_SETTING_MANAGER.themeColor];
    [self setAvatorInUIImageView:_recommandUserAvator1 AndUserNameInLabel:_recommandUserNameLabel1 withUserInfo:(User *)[userArray objectAtIndex:0]];
    [self setAvatorInUIImageView:_recommandUserAvator2 AndUserNameInLabel:_recommandUserNameLabel2 withUserInfo:(User *)[userArray objectAtIndex:1]];
    [self setAvatorInUIImageView:_recommandUserAvator3 AndUserNameInLabel:_recommandUserNameLabel3 withUserInfo:(User *)[userArray objectAtIndex:2]];
    [self setAvatorInUIImageView:_recommandUserAvator4 AndUserNameInLabel:_recommandUserNameLabel4 withUserInfo:(User *)[userArray objectAtIndex:3]];
    
    UIGraphicsBeginImageContext(CGSizeMake(320.0, 1.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0] CGColor]);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 320.0, 0.0);
    CGContextStrokePath(context);
    UIImage * linePic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_shadowLineImageView setImage:linePic];
}

- (void)setAvatorInUIImageView:(UIImageView *) imageView
            AndUserNameInLabel:(UILabel *)label
                  withUserInfo:(User *)user
{
    [imageView setImage:nil];
    [imageView setImageFromURLString:user.avatarLargeUrl
                                placeHolderImage:nil animation:YES completion:nil];
    imageView.layer.cornerRadius = 25.0;
    imageView.layer.masksToBounds = YES;
    
    [label setText:user.name];
    [label setTextColor:kRecommandCellTextColor];
}

@end
