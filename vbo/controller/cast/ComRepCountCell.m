//
//  ComRepCountCell.m
//  vbo
//
//  Created by Emerson on 13-11-20.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "ComRepCountCell.h"

@interface ComRepCountCell()

@property (nonatomic, weak) IBOutlet UILabel * countsLabel;

@end

@implementation ComRepCountCell

- (void)awakeFromNib
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setComRepCountLabel:(NSString *)labelString
{
    [self.countsLabel setText:labelString];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
