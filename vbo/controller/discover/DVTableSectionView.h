//
//  DiscoverTableSectionView.h
//  vbo
//
//  Created by Emerson on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
	DCSegmentTalk = 0,
	DCSegmentWeibo,
	DCSegmentUser,
} DiscoverSegmentType;

@protocol DVTableSectionViewDelegate <NSObject>

- (void)segmentControlPressed:(DiscoverSegmentType)segmentType;

@end

@interface DVTableSectionView : UIView

@property (nonatomic, strong) UITableView * segmentControlTableView;
@property (nonatomic, weak) id<DVTableSectionViewDelegate> delegate;

@end