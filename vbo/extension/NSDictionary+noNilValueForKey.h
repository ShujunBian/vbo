//
//  NSDictionary+noNullValueForKey.h
//  vbo
//
//  Created by wxy325 on 11/8/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (noNilValueForKey)
- (id)noNilValueForKey:(NSString*)key;
@end
