//
//  CastViewCell.m
//  vbo
//
//  Created by Emerson on 13-11-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastViewCell.h"

@interface CastViewCell()

@property (nonatomic,weak) IBOutlet UIImageView * weiboImage;
@property (nonatomic,weak) IBOutlet UIImageView * userAvator;

@property (nonatomic,weak) IBOutlet UILabel * currentTimeLabel;
@property (nonatomic,weak) IBOutlet UILabel * userNickname;
@property (nonatomic,weak) IBOutlet UILabel * weiboContentLabel;
@property (nonatomic,weak) IBOutlet UILabel * likeTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * commentTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * repostTimesLabel;

@property (nonatomic,weak) IBOutlet UIButton * likeButton;
@property (nonatomic,weak) IBOutlet UIButton * commentButton;
@property (nonatomic,weak) IBOutlet UIButton * repostButton;


@end

@implementation CastViewCell

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

@end
