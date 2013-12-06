//
//  DiscoverTableSectionView.m
//  vbo
//
//  Created by Emerson on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "DVTableSectionView.h"

@interface DVTableSectionView()

@property (nonatomic, weak) IBOutlet UILabel * discoverSectionTitle;
@property (nonatomic, weak) IBOutlet UISegmentedControl * discoverSectionSegmentControl;

@end

@implementation DVTableSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setBackgroundColor:[UIColor colorWithRed:246.0 / 255.0 green:244.0 / 255.0 blue:240.0 / 255.0 alpha:1.0]];
    [_discoverSectionTitle setTextColor:SHARE_SETTING_MANAGER.themeColor];
    
    [_discoverSectionSegmentControl setSelectedSegmentIndex:DCSegmentWeibo];
    [_discoverSectionSegmentControl addTarget:self action:@selector(segmentControlPressed) forControlEvents:UIControlEventValueChanged];
    
}

- (void)segmentControlPressed
{
    if (_delegate && [_delegate respondsToSelector:@selector(segmentControlPressed:)]) {
        [_delegate segmentControlPressed:_discoverSectionSegmentControl.selectedSegmentIndex];
    }
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
