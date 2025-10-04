# LWKBCommonUtils

[English](./README.md) | [中文版](./README_ZH.md) | [Swift Version](./README_SWIFT_VERSION.md)

[![CI Status](https://img.shields.io/travis/luowei/LWKBCommonUtils.svg?style=flat)](https://travis-ci.org/luowei/LWKBCommonUtils)
[![Version](https://img.shields.io/cocoapods/v/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)
[![License](https://img.shields.io/cocoapods/l/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)
[![Platform](https://img.shields.io/cocoapods/p/LWKBCommonUtils.svg?style=flat)](https://cocoapods.org/pods/LWKBCommonUtils)

> A comprehensive collection of utility macros and data synchronization tools for iOS development, designed to simplify common development tasks and enable seamless data sharing between apps and extensions.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Utility Macros (AppDefines.h)](#utility-macros-appdefines-h)
  - [Data Sync Manager (LWDataPipeManager)](#data-sync-manager-lwdatapipemanager)
- [API Reference](#api-reference)
- [Architecture](#architecture)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Example Project](#example-project)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Introduction

LWKBCommonUtils is a powerful iOS utility library that streamlines common development tasks. It provides two main components:

1. **AppDefines.h**: A comprehensive collection of utility macros for system version checks, device detection, screen dimensions, thread safety, and memory management.
2. **LWDataPipeManager**: An intelligent data synchronization manager that seamlessly handles data sharing between UserDefaults and App Groups, perfect for apps with extensions (keyboards, widgets, etc.).

## Features

### Core Utilities
- **System Version Checks**: Easy-to-use macros for iOS version comparison
- **Device Detection**: Identify iPad, iPad Pro, and notch-enabled devices
- **Screen Properties**: Access screen dimensions, scale, and orientation
- **Thread Safety**: Safe main thread execution with deadlock prevention
- **Memory Management**: Weak/strong reference helpers to prevent retain cycles
- **Debug Logging**: Conditional logging that only runs in DEBUG builds

### Data Synchronization
- **Unified Storage API**: Single interface for both UserDefaults and App Groups
- **Automatic Sync**: Seamless data synchronization between app and extensions
- **Fallback Mechanism**: Intelligent data retrieval with automatic fallback
- **Extension Support**: Perfect for keyboard extensions, widgets, and other app extensions

### Additional Features
- **Character Detection**: Identify Chinese characters
- **Settings Navigation**: Direct links to iOS keyboard settings
- **App Group Configuration**: Easy setup for app group data sharing

## Requirements

- **iOS**: 8.0 or later
- **Xcode**: 8.0 or later
- **Language**: Objective-C
- **CocoaPods**: 1.0.0 or later (for installation)

## Installation

### CocoaPods

LWKBCommonUtils is available through [CocoaPods](https://cocoapods.org). To install it, add the following line to your Podfile:

```ruby
pod 'LWKBCommonUtils'
```

Then run:

```bash
pod install
```

### Manual Installation

1. Download the source code
2. Add the following files to your project:
   - `AppDefines.h`
   - `LWDataPipeManager.h`
   - `LWDataPipeManager.m`
3. Import the headers where needed

## Quick Start

### Basic Setup

Import the headers in your project:

```objective-c
#import <LWKBCommonUtils/AppDefines.h>
#import <LWKBCommonUtils/LWDataPipeManager.h>
```

### Example 1: System Version Check

```objective-c
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"14.0")) {
    // Use iOS 14+ features
    [self setupModernUI];
} else {
    // Fallback for older versions
    [self setupLegacyUI];
}
```

### Example 2: Device-Specific Layout

```objective-c
CGFloat topPadding = HasTopNotch ? 44.0 : 20.0;
CGFloat buttonWidth = Screen_W * 0.9;

if (IS_IPAD_PRO) {
    buttonWidth = 600.0; // Fixed width for iPad Pro
}
```

### Example 3: Data Sharing Between App and Extension

In your main app:
```objective-c
// Save user preferences
[LWDataPipeManager setValue:@"dark" key:@"theme"];
[LWDataPipeManager setValue:@YES key:@"soundEnabled"];
```

In your keyboard extension:
```objective-c
// Read shared preferences
NSString *theme = [LWDataPipeManager getValueByKey:@"theme"];
BOOL soundEnabled = [[LWDataPipeManager getValueByKey:@"soundEnabled"] boolValue];
```

### Example 4: Thread-Safe UI Updates

```objective-c
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // Perform time-consuming task
    NSData *imageData = [self downloadImage];

    // Safely update UI on main thread
    dispatch_main_sync_safe(^{
        self.imageView.image = [UIImage imageWithData:imageData];
    });
});
```

## Usage

### Utility Macros (AppDefines.h)

Import the header file:
```objective-c
#import <LWKBCommonUtils/AppDefines.h>
```

#### Complete Macro Definitions Reference

**System Version Comparison Macros:**
```objective-c
SYSTEM_VERSION_EQUAL_TO(v)                  // Returns YES if system version equals v
SYSTEM_VERSION_GREATER_THAN(v)              // Returns YES if system version > v
SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  // Returns YES if system version >= v
SYSTEM_VERSION_LESS_THAN(v)                 // Returns YES if system version < v
SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     // Returns YES if system version <= v
```

**Debug Logging:**
```objective-c
Log(format, ...)                            // NSLog in DEBUG mode, nothing in RELEASE
```

**Memory Management:**
```objective-c
weakify(var)                                // Creates weak reference: weak_##var
strongify(var)                              // Creates strong reference from weak reference
WEAKSELF                                    // Creates weakSelf from self
```

**Thread Safety:**
```objective-c
dispatch_main_sync_safe(block)              // Safely executes block on main thread
```

**Screen Properties:**
```objective-c
Scr_Scale                                   // Screen scale factor
Screen_W                                    // Current screen width
Screen_H                                    // Current screen height
IsLandscape                                 // YES if in landscape orientation
Screen_Protrait_W                           // Screen width in portrait mode
Screen_Protrait_H                           // Screen height in portrait mode
ExceptNotch_H                               // Screen height excluding notch area
```

**Device Detection:**
```objective-c
IS_IPAD                                     // YES if device is iPad
IS_IPAD_PRO                                 // YES if device is iPad Pro (excludes 768x1024)
HasTopNotch                                 // YES if device has notch (iPhone X and later)
```

**Character Detection:**
```objective-c
IS_CH_SYMBOL(chr)                           // Returns YES if character ASCII > 127
```

**App Configuration:**
```objective-c
GroupId                                     // App Group ID from Info.plist
PrefsURLString                              // Settings URL for iOS < 10
PrefsURLString_iOS10                        // Settings URL for iOS >= 10
```

#### System Version Comparison

Compare iOS system versions:
```objective-c
// Check if system version equals specific version
if (SYSTEM_VERSION_EQUAL_TO(@"13.0")) {
    // Code for iOS 13.0
}

// Check if system version is greater than specific version
if (SYSTEM_VERSION_GREATER_THAN(@"12.0")) {
    // Code for iOS > 12.0
}

// Check if system version is greater than or equal to specific version
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
    // Code for iOS >= 11.0
}

// Check if system version is less than specific version
if (SYSTEM_VERSION_LESS_THAN(@"14.0")) {
    // Code for iOS < 14.0
}

// Check if system version is less than or equal to specific version
if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"13.0")) {
    // Code for iOS <= 13.0
}
```

#### Logging

Debug logging that only works in DEBUG builds:
```objective-c
Log(@"Debug message: %@", someObject);
// Expands to NSLog in DEBUG, nothing in RELEASE
```

#### Weak/Strong Reference Management

Prevent retain cycles in blocks:
```objective-c
// Create weak reference
weakify(self);
[self.someObject doSomethingWithBlock:^{
    // Create strong reference from weak reference
    strongify(self);
    [self doSomething];
}];

// Alternative syntax
WEAKSELF
[self.someObject doSomethingWithBlock:^{
    [weakSelf doSomething];
}];
```

#### Thread Safety

Execute code safely on main thread:
```objective-c
dispatch_main_sync_safe(^{
    // This code will execute on main thread
    // If already on main thread, executes immediately
    // Otherwise, dispatches synchronously to main queue
    [self updateUI];
});
```

#### Screen Dimensions

Access screen size and properties:
```objective-c
// Screen width and height
CGFloat width = Screen_W;
CGFloat height = Screen_H;

// Screen scale
CGFloat scale = Scr_Scale;

// Check orientation
BOOL isLandscape = IsLandscape;

// Portrait screen dimensions (regardless of current orientation)
CGFloat portraitWidth = Screen_Protrait_W;
CGFloat portraitHeight = Screen_Protrait_H;

// Adjust height excluding notch area
CGFloat adjustedHeight = ExceptNotch_H;
```

#### Device Detection

Detect device type and characteristics:
```objective-c
// Check if device is iPad
if (IS_IPAD) {
    // iPad-specific code
}

// Check if device is iPad Pro
if (IS_IPAD_PRO) {
    // iPad Pro-specific code
}

// Check if device has top notch (iPhone X and later)
if (HasTopNotch) {
    // Handle notch spacing
}
```

#### Character Detection

Check if character is Chinese:
```objective-c
char chr = 'A';
if (IS_CH_SYMBOL(chr)) {
    // Character is Chinese
}
```

#### App Group ID

Access App Group identifier from Info.plist:
```objective-c
NSString *groupId = GroupId;
```

#### Settings URL Navigation

Navigate to iOS keyboard settings (useful for keyboard extensions):
```objective-c
// For iOS 9 and earlier
NSURL *settingsURL = [NSURL URLWithString:PrefsURLString];
[[UIApplication sharedApplication] openURL:settingsURL];

// For iOS 10 and later
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
    NSURL *settingsURL = [NSURL URLWithString:PrefsURLString_iOS10];
    [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
} else {
    NSURL *settingsURL = [NSURL URLWithString:PrefsURLString];
    [[UIApplication sharedApplication] openURL:settingsURL];
}
```

**Note:** These macros construct the settings URL string programmatically to avoid App Store review issues.

### Data Sync Manager (LWDataPipeManager)

The `LWDataPipeManager` provides seamless data synchronization between UserDefaults and App Groups, perfect for sharing data between your main app and app extensions (like keyboard extensions).

Import the header file:
```objective-c
#import <LWKBCommonUtils/LWDataPipeManager.h>
```

#### Unified Data Access

Get and set values with automatic synchronization:
```objective-c
// Set value - automatically syncs to both UserDefaults and App Group
[LWDataPipeManager setValue:@"Some Value" key:@"myKey"];

// Get value - automatically checks App Group first, falls back to UserDefaults
id value = [LWDataPipeManager getValueByKey:@"myKey"];
```

**How it works:**
- `setValue:key:` writes to both UserDefaults and App Group storage simultaneously
- `getValueByKey:` first attempts to read from App Group storage. If not found, it reads from UserDefaults and automatically syncs the value to App Group storage for future access

#### UserDefaults Access

Direct access to UserDefaults:
```objective-c
// Set value in UserDefaults
[LWDataPipeManager setUserDefaultValue:@"Value" withKey:@"userDefaultKey"];

// Get value from UserDefaults
id value = [LWDataPipeManager getUserDefaultValueByKey:@"userDefaultKey"];
```

#### App Group Access

Direct access to App Group shared storage:
```objective-c
// Set value in App Group (group.com.wodedata.LWInputMethod)
[LWDataPipeManager setMyInputMethodAPPGroupValue:@"Shared Value" withKey:@"sharedKey"];

// Get value from App Group
id sharedValue = [LWDataPipeManager getMyInputMethodAPPGroupValueByKey:@"sharedKey"];
```

**Note:** The current implementation uses the App Group identifier `group.com.wodedata.LWInputMethod`. You may want to customize this for your application by modifying the `LWDataPipeManager` implementation.

#### App Group Configuration

To use the App Group functionality with your own app:

1. **Enable App Groups in Xcode:**
   - Select your target in Xcode
   - Go to "Signing & Capabilities" tab
   - Click "+ Capability" and add "App Groups"
   - Create or select an App Group identifier (e.g., `group.com.yourcompany.yourapp`)

2. **Configure Info.plist:**
   - Add a new key `GroupId` (String type) to your Info.plist
   - Set the value to your App Group identifier
   - This allows the `GroupId` macro to retrieve the identifier

3. **Customize LWDataPipeManager (Optional):**
   - If you want to use a different App Group identifier in the code
   - Modify `LWDataPipeManager.m` and replace `group.com.wodedata.LWInputMethod` with your identifier
   - Or use the `GroupId` macro from Info.plist

4. **Enable for Extensions:**
   - Repeat steps 1-2 for any app extensions (keyboard, widget, etc.)
   - Ensure all targets use the same App Group identifier

**Example Info.plist Configuration:**
```xml
<key>GroupId</key>
<string>group.com.yourcompany.yourapp</string>
```

**App Group Identifier Format:**
- Must start with `group.`
- Should follow reverse domain notation
- Example: `group.com.yourcompany.appname`

#### Use Cases

**Example 1: Sharing user preferences between app and keyboard extension**
```objective-c
// In main app
[LWDataPipeManager setValue:@YES key:@"soundEnabled"];

// In keyboard extension
BOOL soundEnabled = [[LWDataPipeManager getValueByKey:@"soundEnabled"] boolValue];
```

**Example 2: Syncing custom dictionaries**
```objective-c
// Save custom word list
NSArray *customWords = @[@"word1", @"word2", @"word3"];
[LWDataPipeManager setValue:customWords key:@"customWords"];

// Access from extension
NSArray *words = [LWDataPipeManager getValueByKey:@"customWords"];
```

**Example 3: Theme synchronization**
```objective-c
// Set theme in main app
NSDictionary *theme = @{
    @"backgroundColor": @"#FFFFFF",
    @"textColor": @"#000000",
    @"fontSize": @14
};
[LWDataPipeManager setValue:theme key:@"currentTheme"];

// Apply theme in keyboard extension
NSDictionary *theme = [LWDataPipeManager getValueByKey:@"currentTheme"];
```

## Example Project

To explore the full functionality of LWKBCommonUtils, check out the example project:

```bash
git clone https://github.com/luowei/LWKBCommonUtils.git
cd LWKBCommonUtils/Example
pod install
open LWKBCommonUtils.xcworkspace
```

The example project demonstrates:
- System version detection and handling
- Device type identification
- Screen dimension adaptation
- Data synchronization between app and extension
- Thread-safe operations
- Memory management best practices

## Architecture

### Components

1. **AppDefines.h** - Utility macros for common iOS development tasks
   - System version checks
   - Device detection
   - Screen dimension helpers
   - Thread safety utilities
   - Memory management helpers

2. **LWDataPipeManager** - Data synchronization manager
   - Unified API for UserDefaults and App Group storage
   - Automatic fallback and sync mechanisms
   - Perfect for app extension data sharing

### Macro Implementation Details

#### System Version Comparison
Uses `NSNumericSearch` option for accurate version string comparison:
```objective-c
// Implementation example
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
```

#### Memory Management (weakify/strongify)
Prevents retain cycles while avoiding compiler warnings:
```objective-c
// weakify creates: __weak typeof(self) weak_self = self;
#define weakify(var) __weak typeof(var) weak_##var = var;

// strongify creates: __strong typeof(self) self = weak_self;
// Uses pragma to suppress shadow variable warnings
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop")
```

#### Thread Safety
Checks current thread to avoid deadlock:
```objective-c
// Executes immediately if already on main thread
// Otherwise dispatches synchronously to avoid race conditions
#define dispatch_main_sync_safe(block) \
    if ([NSThread isMainThread]) { \
        block(); \
    } else { \
        dispatch_sync(dispatch_get_main_queue(), block); \
    }
```

#### Device Detection
Uses screen dimensions for accurate device identification:
```objective-c
// HasTopNotch checks for iPhone X and later models (height >= 812pt)
#define HasTopNotch \
    (([UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPhone) && \
     ([[UIScreen mainScreen] bounds].size.height >= 812.0f))
```

## API Reference

### AppDefines.h Macros

| Macro | Description | Example |
|-------|-------------|---------|
| `SYSTEM_VERSION_EQUAL_TO(v)` | Check if system version equals v | `SYSTEM_VERSION_EQUAL_TO(@"14.0")` |
| `SYSTEM_VERSION_GREATER_THAN(v)` | Check if system version > v | `SYSTEM_VERSION_GREATER_THAN(@"13.0")` |
| `SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)` | Check if system version >= v | `SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.0")` |
| `SYSTEM_VERSION_LESS_THAN(v)` | Check if system version < v | `SYSTEM_VERSION_LESS_THAN(@"15.0")` |
| `SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)` | Check if system version <= v | `SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"14.0")` |
| `Log(format, ...)` | Debug logging (DEBUG only) | `Log(@"Value: %@", obj)` |
| `weakify(var)` | Create weak reference | `weakify(self)` |
| `strongify(var)` | Create strong reference from weak | `strongify(self)` |
| `WEAKSELF` | Create weakSelf from self | `WEAKSELF` |
| `dispatch_main_sync_safe(block)` | Execute block safely on main thread | `dispatch_main_sync_safe(^{ ... })` |
| `Scr_Scale` | Screen scale factor | `CGFloat scale = Scr_Scale;` |
| `Screen_W` | Current screen width | `CGFloat w = Screen_W;` |
| `Screen_H` | Current screen height | `CGFloat h = Screen_H;` |
| `IsLandscape` | Check if in landscape mode | `if (IsLandscape) { ... }` |
| `Screen_Protrait_W` | Screen width in portrait | `CGFloat w = Screen_Protrait_W;` |
| `Screen_Protrait_H` | Screen height in portrait | `CGFloat h = Screen_Protrait_H;` |
| `ExceptNotch_H` | Height excluding notch area | `CGFloat h = ExceptNotch_H;` |
| `IS_IPAD` | Check if device is iPad | `if (IS_IPAD) { ... }` |
| `IS_IPAD_PRO` | Check if device is iPad Pro | `if (IS_IPAD_PRO) { ... }` |
| `HasTopNotch` | Check if device has notch | `if (HasTopNotch) { ... }` |
| `IS_CH_SYMBOL(chr)` | Check if character is Chinese | `if (IS_CH_SYMBOL(c)) { ... }` |
| `GroupId` | App Group ID from Info.plist | `NSString *id = GroupId;` |
| `PrefsURLString` | Settings URL (iOS < 10) | `[NSURL URLWithString:PrefsURLString]` |
| `PrefsURLString_iOS10` | Settings URL (iOS >= 10) | `[NSURL URLWithString:PrefsURLString_iOS10]` |

### LWDataPipeManager Class Methods

| Method | Description | Return Type |
|--------|-------------|-------------|
| `+getValueByKey:(NSString *)key` | Get value with automatic sync (checks App Group first, then UserDefaults) | `id` |
| `+setValue:(id)value key:(NSString *)key` | Set value to both UserDefaults and App Group | `void` |
| `+getUserDefaultValueByKey:(NSString *)key` | Get value from UserDefaults only | `id` |
| `+setUserDefaultValue:(id)value withKey:(NSString *)key` | Set value to UserDefaults only | `void` |
| `+getMyInputMethodAPPGroupValueByKey:(NSString *)key` | Get value from App Group only | `id` |
| `+setMyInputMethodAPPGroupValue:(id)value withKey:(NSString *)key` | Set value to App Group only | `void` |

### Data Synchronization Flow

**Reading Data (`getValueByKey:`):**
1. First attempts to read from App Group storage
2. If not found, reads from UserDefaults
3. Automatically syncs the value to App Group for future access
4. Returns the value

**Writing Data (`setValue:key:`):**
1. Writes to UserDefaults
2. Writes to App Group storage
3. Ensures data consistency across app and extensions

## Best Practices

### Memory Management
```objective-c
// Good: Prevents retain cycles
weakify(self);
[self.service requestWithCompletion:^(id result) {
    strongify(self);
    if (!self) return;  // Check if self still exists
    [self handleResult:result];
}];

// Bad: Creates retain cycle
[self.service requestWithCompletion:^(id result) {
    [self handleResult:result];  // Retains self
}];
```

### Thread Safety
```objective-c
// Good: Safe UI update from any thread
dispatch_main_sync_safe(^{
    self.label.text = @"Updated";
});

// Bad: Potential crash if not on main thread
self.label.text = @"Updated";
```

### Data Synchronization
```objective-c
// Good: Use unified API for automatic sync
[LWDataPipeManager setValue:@"value" key:@"key"];
id value = [LWDataPipeManager getValueByKey:@"key"];

// Use specific methods only when you need direct control
[LWDataPipeManager setUserDefaultValue:@"local" withKey:@"localKey"];
```

### System Version Checks
```objective-c
// Good: Clear and readable
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0")) {
    // Use iOS 13+ features
} else {
    // Fallback for older versions
}

// Bad: Manual string comparison
if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
    // May not work correctly with versions like "13.0.1"
}
```

## Troubleshooting

### App Group Not Working

**Problem:** Data not syncing between app and extension.

**Solutions:**
1. Verify App Group is enabled in both targets' capabilities
2. Check that both targets use the same App Group identifier
3. Confirm Info.plist contains the correct `GroupId` entry
4. Ensure the App Group identifier in code matches your configuration
5. Verify signing and provisioning profiles include App Groups entitlement

### Keyboard Settings URL Not Working

**Problem:** Settings URL doesn't open keyboard settings.

**Solutions:**
1. Use `PrefsURLString_iOS10` for iOS 10+
2. Ensure you have proper permissions in Info.plist
3. Note that simulator may behave differently than device
4. Check that the URL scheme is correctly constructed

### Weak/Strong Reference Issues

**Problem:** Compiler warnings or unexpected behavior with weakify/strongify.

**Solutions:**
1. Always use `strongify` after `weakify` in blocks
2. Check if `self` is nil after `strongify`
3. Don't use variables in the same scope with the same name
4. Ensure proper pairing of weakify/strongify calls

### Build Errors

**Problem:** Header files not found after installation.

**Solutions:**
1. Clean build folder (Command + Shift + K)
2. Run `pod install` again
3. Verify the pod is correctly listed in your Podfile
4. Check that you're opening the `.xcworkspace` file, not `.xcodeproj`

## Contributing

We welcome contributions to LWKBCommonUtils! Here's how you can help:

### Reporting Issues

If you find a bug or have a feature request:
1. Check if the issue already exists in the issue tracker
2. Provide detailed information about the problem
3. Include code samples, error messages, and system information
4. Describe expected vs actual behavior

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes and test thoroughly
4. Commit your changes with clear messages
5. Push to your branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request with a detailed description

### Development Guidelines

- Follow the existing code style
- Add comments for complex logic
- Update documentation for new features
- Ensure backward compatibility when possible
- Test on multiple iOS versions and devices

## Author

**luowei**
- Email: luowei@wodedata.com
- GitHub: [@luowei](https://github.com/luowei)

## License

LWKBCommonUtils is available under the MIT license. This means you can freely use, modify, and distribute this library in your projects, including commercial applications.

See the [LICENSE](LICENSE) file for the full license text.

---

**Copyright (c) 2025 luowei**

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

If you find LWKBCommonUtils helpful, please consider giving it a star on GitHub!
