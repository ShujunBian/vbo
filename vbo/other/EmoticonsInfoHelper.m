//
//  EmoticonsInfoHelper.m
//  vbo
//
//  Created by Emerson on 13-11-25.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "EmoticonsInfoHelper.h"

static EmoticonsInfoHelper * sharedEmoticonsInfoHelper ;

#define kImageFileName                      @"ImageName"
#define kEmoticonsInfoDict                  @"EmoticonsInfoDict"

@interface EmoticonsInfoHelper()

@property (nonatomic, strong) NSMutableDictionary *originalEmoticonsInfoDict;
@property (nonatomic, strong) NSMutableDictionary *emoticonsInfoDict;

@end

@implementation EmoticonsInfoHelper

+ (EmoticonsInfoHelper *)sharedEmoticonsInfoHelper {
    if (!sharedEmoticonsInfoHelper) {
        sharedEmoticonsInfoHelper = [[EmoticonsInfoHelper alloc] init];
    }
    return sharedEmoticonsInfoHelper;
}

- (id)init {
    self = [super init];
    if (self) {
        [self readPlist];
    }
    return self;
}


- (void)readPlist {
    NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"EmoticonsInfo" ofType:@"plist"];
    self.originalEmoticonsInfoDict = [[[NSMutableDictionary alloc] initWithContentsOfFile:configFilePath] objectForKey:kEmoticonsInfoDict];
    
    self.emoticonsInfoDict = [NSMutableDictionary dictionaryWithCapacity:self.originalEmoticonsInfoDict.count];
    [self.originalEmoticonsInfoDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        EmoticonsInfo *info = [[EmoticonsInfo alloc] initWithDict:obj andKey:key];
        [self.emoticonsInfoDict setObject:info forKey:key];
    }];
}


- (EmoticonsInfo *)emoticonsInfoForKey:(NSString *)key {
    return [self.emoticonsInfoDict objectForKey:key];
}

@end


@implementation EmoticonsInfo

- (id)initWithDict:(NSDictionary *)dict andKey:(NSString *)key {
    self = [super init];
    if (self) {
        self.keyName = key;
        
        self.imageFileName = [dict objectForKey:kImageFileName];
    }
    return self;
}

@end
