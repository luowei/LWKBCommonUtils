//
//  AppDefines.h.h
//  MyInputMethod
//
//  Created by Luo Wei on 2017/5/16.
//  Copyright (c) 2017 luowei. All rights reserved.
//

#ifndef AppDefines_h_h
#define AppDefines_h_h

#import "UIKit/UIKit.h"

// -------- 常用宏定义

//版本比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#ifdef DEBUG
#define Log(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define Log(format, ...)
#endif

#define weakify(var) __weak typeof(var) weak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop")


#define GroupId [NSBundle mainBundle].infoDictionary[@"GroupId"]

//是否中文字符
#define IS_CH_SYMBOL(chr) ((int)(chr)>127)


#pragma mark - Oporation Defines

//在主线程同步安全执行
#define dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

#define Scr_Scale [UIScreen mainScreen].scale

#define WEAKSELF typeof(self) __weak weakSelf = self;

#define AfterDate_Review @"2020-07-03"
//#define PrefsURLString @"prefs:root=General&path=Keyboard/KEYBOARDS"
//#define PrefsURLString_iOS10 @"App-Prefs:root=General&path=Keyboard/KEYBOARDS"
#define PrefsURLString ([[@"pre" stringByAppendingString:@"fs:ro"] stringByAppendingString:@"ot=General&path=Keyboard/KEYBOARDS"])
#define PrefsURLString_iOS10 ([[@"App-Pre" stringByAppendingString:@"fs:ro"] stringByAppendingString:@"ot=General&path=Keyboard/KEYBOARDS"])

//屏幕宽度,高度
#define Screen_W ((CGFloat)([UIScreen mainScreen].bounds.size.width))
#define Screen_H ((CGFloat)([UIScreen mainScreen].bounds.size.height))

//竖屏时的屏幕宽度
#define IsLandscape (Screen_W > Screen_H ? YES : NO)
#define Screen_Protrait_W (Screen_W > Screen_H ? Screen_H : Screen_W)
#define Screen_Protrait_H (Screen_W > Screen_H ? Screen_W : Screen_H)

//是否ipad pro,排除 768x1024 的 ipad pro
#define IS_IPAD ([UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IPAD_PRO_H (MAX(Screen_W,Screen_H))
#define IS_IPAD_PRO (IS_IPAD && (IPAD_PRO_H == 1112.0 || IPAD_PRO_H == 1194.0 || IPAD_PRO_H == 1366.0))

//留海屏
//iphone分辨率：https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
//#define HasTopNotch ((@available(iOS 11.0, *) && ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top > 20.0)) ? YES : NO)
#define HasTopNotch (([UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPhone) && ([[UIScreen mainScreen] bounds].size.height >= 812.0f))
#define ExceptNotch_H (HasTopNotch ? (Screen_H-108) : (IS_IPAD_PRO ? Screen_H-48 :Screen_H) )

#endif /* AppDefines_h_h */
