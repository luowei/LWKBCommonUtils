# LWKBCommonUtils

[![CI Status](https://img.shields.io/travis/luowei/LWKBCommonUtils.svg?style=flat)](https://travis-ci.org/luowei/LWKBCommonUtils)
[![Version](https://img.shields.io/cocoapods/v/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)
[![License](https://img.shields.io/cocoapods/l/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)
[![Platform](https://img.shields.io/cocoapods/p/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)

## 简介

LWKBCommonUtils 是一个 iOS 开发常用工具库，提供了一系列常用的宏定义和数据管理工具类，旨在简化 iOS 应用开发过程。本库包含系统版本判断、屏幕尺寸适配、线程安全操作以及 App Group 数据共享等实用功能。

## 主要功能

### 1. AppDefines.h - 常用宏定义

#### 系统版本判断
提供了一套完整的 iOS 系统版本比较宏：

```objective-c
// 判断系统版本是否等于指定版本
SYSTEM_VERSION_EQUAL_TO(v)

// 判断系统版本是否大于指定版本
SYSTEM_VERSION_GREATER_THAN(v)

// 判断系统版本是否大于或等于指定版本
SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)

// 判断系统版本是否小于指定版本
SYSTEM_VERSION_LESS_THAN(v)

// 判断系统版本是否小于或等于指定版本
SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)
```

**使用示例：**
```objective-c
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
    // iOS 13.0 及以上版本的代码
}
```

#### 调试日志
```objective-c
Log(format, ...)  // Debug 模式下打印日志，Release 模式下不输出
```

#### 内存管理宏
```objective-c
// 创建弱引用
weakify(var)

// 将弱引用转换为强引用
strongify(var)

// 弱引用 self（简化版）
WEAKSELF
```

**使用示例：**
```objective-c
weakify(self);
[self.button addActionHandler:^{
    strongify(self);
    [self doSomething];
}];
```

#### 线程安全操作
```objective-c
// 在主线程同步安全执行代码块
dispatch_main_sync_safe(block)
```

**使用示例：**
```objective-c
dispatch_main_sync_safe(^{
    self.label.text = @"更新 UI";
});
```

#### 屏幕尺寸相关
```objective-c
// 屏幕缩放比例
Scr_Scale

// 屏幕宽度和高度
Screen_W    // 当前屏幕宽度
Screen_H    // 当前屏幕高度

// 判断是否为横屏
IsLandscape

// 竖屏时的屏幕宽度和高度
Screen_Protrait_W
Screen_Protrait_H

// iPad 设备判断
IS_IPAD           // 是否为 iPad
IS_IPAD_PRO       // 是否为 iPad Pro（排除 768x1024 的 iPad）

// 刘海屏（异形屏）判断
HasTopNotch       // 是否为刘海屏设备（iPhone X 及后续机型）
ExceptNotch_H     // 扣除刘海区域后的屏幕高度
```

**使用示例：**
```objective-c
CGFloat viewWidth = Screen_W * 0.8;

if (HasTopNotch) {
    // 适配刘海屏的代码
    CGFloat safeHeight = ExceptNotch_H;
}

if (IS_IPAD_PRO) {
    // iPad Pro 特殊处理
}
```

#### 字符判断
```objective-c
// 判断是否为中文字符（ASCII 值大于 127）
IS_CH_SYMBOL(chr)
```

#### 其他工具宏
```objective-c
// 获取 App Group ID
GroupId

// 设置跳转链接（iOS 键盘设置页面）
PrefsURLString           // iOS 10 以下版本
PrefsURLString_iOS10     // iOS 10 及以上版本
```

### 2. LWDataPipeManager - 数据管道管理器

`LWDataPipeManager` 是一个数据存储和同步工具类，提供了 UserDefaults 和 App Group 之间的数据共享功能，特别适用于主应用与扩展（如键盘扩展）之间的数据通信。

#### 核心方法

##### 统一数据访问接口
```objective-c
// 获取数据（优先从 App Group 读取，如不存在则从 UserDefaults 读取并同步到 App Group）
+ (id)getValueByKey:(NSString *)key;

// 设置数据（同时写入 UserDefaults 和 App Group）
+ (void)setValue:(id)value key:(NSString *)key;
```

##### UserDefaults 操作
```objective-c
// 从 UserDefaults 中读取数据
+ (id)getUserDefaultValueByKey:(NSString *)key;

// 向 UserDefaults 写入数据
+ (void)setUserDefaultValue:(id)value withKey:(NSString *)key;
```

##### App Group 操作
```objective-c
// 从 App Group 中读取数据
+ (id)getMyInputMethodAPPGroupValueByKey:(NSString *)key;

// 向 App Group 写入数据
+ (void)setMyInputMethodAPPGroupValue:(id)value withKey:(NSString *)key;
```

#### 使用示例

```objective-c
// 保存用户设置（同时存储到 UserDefaults 和 App Group）
[LWDataPipeManager setValue:@"enabled" key:@"keyboard_sound"];

// 读取用户设置（自动从最佳存储位置读取）
NSString *soundSetting = [LWDataPipeManager getValueByKey:@"keyboard_sound"];

// 仅操作 UserDefaults
[LWDataPipeManager setUserDefaultValue:@YES withKey:@"first_launch"];
BOOL isFirstLaunch = [[LWDataPipeManager getUserDefaultValueByKey:@"first_launch"] boolValue];

// 仅操作 App Group（用于与键盘扩展共享数据）
[LWDataPipeManager setMyInputMethodAPPGroupValue:@"custom_theme" withKey:@"theme"];
NSString *theme = [LWDataPipeManager getMyInputMethodAPPGroupValueByKey:@"theme"];
```

#### 工作原理

1. **数据读取策略**：`getValueByKey:` 方法首先尝试从 App Group 读取数据，如果不存在，则从 UserDefaults 读取并自动同步到 App Group，确保数据的一致性。

2. **数据写入策略**：`setValue:key:` 方法同时将数据写入 UserDefaults 和 App Group，保证主应用和扩展都能访问最新数据。

3. **App Group 配置**：当前实现使用 `group.com.wodedata.LWInputMethod` 作为 App Group 标识符，如需使用，请在项目中配置对应的 App Group。

## 系统要求

- iOS 8.0 或更高版本
- Xcode 9.0 或更高版本

## 安装

LWKBCommonUtils 通过 [CocoaPods](https://cocoapods.org) 进行分发。要安装它，只需在你的 Podfile 中添加以下代码：

```ruby
pod 'LWKBCommonUtils'
```

然后运行：
```bash
pod install
```

## 示例项目

要运行示例项目，请先克隆仓库，然后在 Example 目录下运行 `pod install`。

```bash
git clone https://gitlab.com/ioslibraries1/lwkbcommonutils.git
cd lwkbcommonutils/Example
pod install
open LWKBCommonUtils.xcworkspace
```

## 使用方法

### 导入头文件

```objective-c
#import <LWKBCommonUtils/AppDefines.h>
#import <LWKBCommonUtils/LWDataPipeManager.h>
```

### 快速开始

#### 1. 使用系统版本判断

```objective-c
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0")) {
    // iOS 14 新特性代码
} else {
    // 兼容旧版本
}
```

#### 2. 屏幕适配

```objective-c
CGFloat buttonWidth = Screen_W * 0.9;
CGFloat buttonHeight = 44.0;

if (HasTopNotch) {
    // 为刘海屏设备添加额外间距
    buttonHeight = 50.0;
}
```

#### 3. 数据共享（主应用与键盘扩展）

在主应用中：
```objective-c
// 保存用户偏好
[LWDataPipeManager setValue:@"dark" key:@"app_theme"];
[LWDataPipeManager setValue:@YES key:@"enable_vibration"];
```

在键盘扩展中：
```objective-c
// 读取用户偏好
NSString *theme = [LWDataPipeManager getValueByKey:@"app_theme"];
BOOL vibrationEnabled = [[LWDataPipeManager getValueByKey:@"enable_vibration"] boolValue];

// 应用设置
if (vibrationEnabled) {
    [self triggerVibration];
}
```

#### 4. 线程安全的 UI 更新

```objective-c
// 从后台线程更新 UI
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 耗时操作
    NSData *data = [self fetchData];

    // 安全地在主线程更新 UI
    dispatch_main_sync_safe(^{
        self.imageView.image = [UIImage imageWithData:data];
    });
});
```

## 注意事项

1. **App Group 配置**：如需使用 `LWDataPipeManager` 的 App Group 功能，请确保：
   - 在 Xcode 项目的 Capabilities 中启用 App Groups
   - 配置正确的 App Group 标识符
   - 如使用自定义 Group ID，需修改 `LWDataPipeManager.m` 中的 `group.com.wodedata.LWInputMethod`

2. **GroupId 宏**：`AppDefines.h` 中的 `GroupId` 宏从 Info.plist 中读取，请在项目的 Info.plist 中添加 `GroupId` 键值对。

3. **线程安全**：使用 `weakify` 和 `strongify` 宏时，注意避免循环引用。

4. **系统版本判断**：版本号字符串需使用标准格式（如 `@"13.0"`），否则可能导致比较结果不准确。

## 适用场景

- iOS 应用开发中的常规工具需求
- 需要进行系统版本适配的项目
- 需要适配不同屏幕尺寸和刘海屏的应用
- 主应用与 App Extension（特别是键盘扩展）之间需要共享数据的项目
- 需要线程安全操作的多线程应用

## 版本历史

### 1.0.0
- 初始版本发布
- 提供常用系统宏定义
- 提供数据管道管理器，支持 UserDefaults 和 App Group 数据共享

## 作者

luowei - luowei@wodedata.com

## 许可证

LWKBCommonUtils 采用 MIT 许可证。详情请参阅 LICENSE 文件。

---

## English Documentation

For English documentation, please refer to [README.md](README.md).
