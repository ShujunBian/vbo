//
//  TShowViewController.h
//  vbo
//
//  Created by Emerson on 13-12-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYBlock.h"

typedef enum{
	ShowUser = 0,
	ShowWeibo,
	ShowTalk,
} ShowType;

typedef void (^FetchBlock)(ArrayBlock succeedBlock, ErrorBlock errorBlock);

@interface TShowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) ShowType currentShowType;

@property (strong, nonatomic) FetchBlock fetchBlock;

@end
