//
//  EmoticonsInfoHelper.h
//  vbo
//
//  Created by Emerson on 13-11-25.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EmoticonsInfo;

@interface EmoticonsInfoHelper : NSObject

+ (EmoticonsInfoHelper *)sharedEmoticonsInfoHelper;

- (EmoticonsInfo *)emoticonsInfoForKey:(NSString *)key;

@end

@interface EmoticonsInfo : NSObject

@property (nonatomic, strong) NSString *keyName;
@property (nonatomic, strong) NSString *imageFileName;

- (id)initWithDict:(NSDictionary *)dict andKey:(NSString *)key;

@end