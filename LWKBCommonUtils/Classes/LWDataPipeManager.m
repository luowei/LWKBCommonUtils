//
// Created by luowei on 2019/1/31.
// Copyright (c) 2019 wodedata. All rights reserved.
//

#import "LWDataPipeManager.h"


@implementation LWDataPipeManager {

}

+(id)getValueByKey:(NSString *)key {
    id value = [LWDataPipeManager getMyInputMethodAPPGroupValueByKey:key];
    if(!value){
        value = [LWDataPipeManager getUserDefaultValueByKey:key];
        [LWDataPipeManager setMyInputMethodAPPGroupValue:value withKey:key];
    }
    return value;
}

+(void)setValue:(id)value key:(NSString *)key {
    [LWDataPipeManager setUserDefaultValue:value withKey:key];
    [LWDataPipeManager setMyInputMethodAPPGroupValue:value withKey:key];
}


//从UserDefault中取值
+(id)getUserDefaultValueByKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

//向UserDefault设置值
+(void)setUserDefaultValue:(id)value withKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

//从APP Group中取值
+(id)getMyInputMethodAPPGroupValueByKey:(NSString *)key {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.wodedata.LWInputMethod"];
    return [userDefaults objectForKey:key];
}

//向APP Group中设置值
+(void)setMyInputMethodAPPGroupValue:(id)value withKey:(NSString *)key {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.wodedata.LWInputMethod"];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}




@end