//
//  LoginUserInfo.h
//  vbo
//
//  Created by wxy325 on 11/19/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUserInfo : NSObject <NSCoding, NSCopying>

@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* accessToken;
@property (strong, nonatomic) NSDate* expireDate;

@end
