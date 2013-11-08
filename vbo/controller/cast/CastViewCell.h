//
//  CastViewCell.h
//  vbo
//
//  Created by Emerson on 13-11-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CastViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView * weiboImage;
@property (nonatomic,weak) IBOutlet UIImageView * userAvator;

@property (nonatomic,weak) IBOutlet UILabel * userNickname;
@property (nonatomic,weak) IBOutlet UILabel * weiboContentLabel;
@property (nonatomic,weak) IBOutlet UILabel * likeTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * commentTimesLabel;
@property (nonatomic,weak) IBOutlet UILabel * repostTimesLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint * avatorTopSpaceConstaint;

@end
