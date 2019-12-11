//
// Created by luowei on 2019/1/31.
// Copyright (c) 2019 wodedata. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LWDataPipeManager : NSObject

+(id)getValueByKey:(NSString *)key;
+(void)setValue:(id)value key:(NSString *)key;

//从UserDefault中取值
+(id)getUserDefaultValueByKey:(NSString *)key;

//向UserDefault设置值
+(void)setUserDefaultValue:(id)value withKey:(NSString *)key;

//从UserDefault中取值
+(id)getMyInputMethodAPPGroupValueByKey:(NSString *)key;

//向APP Group中设置值
+(void)setMyInputMethodAPPGroupValue:(id)value withKey:(NSString *)key;


@end