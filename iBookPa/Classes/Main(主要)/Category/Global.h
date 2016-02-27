//
//  NJGlobal.h
//  07-汽车展示(高级)
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#ifndef _7__________NJGlobal_h
#define _7__________NJGlobal_h

#define InitH(name) \
- (instancetype)initWithDict:(NSDictionary *)dict; \
+ (instancetype)name##WithDict:(NSDictionary *)dict;

#define InitM(name)\
- (instancetype)initWithDict:(NSDictionary *)dict \
{ \
    if (self = [super init]) { \
        [self setValuesForKeysWithDictionary:dict]; \
    } \
    return self; \
} \
+ (instancetype)name##WithDict:(NSDictionary *)dict \
{ \
    return [[self alloc] initWithDict:dict]; \
}

#endif
