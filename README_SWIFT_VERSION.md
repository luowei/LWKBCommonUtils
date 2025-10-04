# LWKBCommonUtils Swift版本使用指南

## 概述

LWKBCommonUtils_swift 是 LWKBCommonUtils 的 Swift 实现版本，提供了常用的工具类、应用配置定义和 SwiftUI 扩展功能。

## 安装

### CocoaPods

在你的 Podfile 中添加：

```ruby
pod 'LWKBCommonUtils_swift'
```

然后运行：

```bash
pod install
```

## 系统要求

- iOS 13.0+
- Swift 5.0+

## 主要功能

### 1. 应用定义（AppDefines）

提供了应用级别的常量定义和配置。

```swift
import LWKBCommonUtils_swift

// 屏幕尺寸相关
let screenWidth = AppDefines.screenWidth
let screenHeight = AppDefines.screenHeight
let screenBounds = AppDefines.screenBounds

// 安全区域
let safeAreaTop = AppDefines.safeAreaTop
let safeAreaBottom = AppDefines.safeAreaBottom

// 状态栏和导航栏
let statusBarHeight = AppDefines.statusBarHeight
let navigationBarHeight = AppDefines.navigationBarHeight
let topBarHeight = AppDefines.topBarHeight

// 设备类型判断
if AppDefines.isIPhone {
    print("当前设备是 iPhone")
}

if AppDefines.isIPad {
    print("当前设备是 iPad")
}

// 系统版本判断
if AppDefines.isIOS13OrLater {
    print("iOS 13 或更高版本")
}

// 设备型号判断
if AppDefines.isIPhoneX {
    print("iPhone X 系列设备")
}
```

### 2. 数据管道管理（LWDataPipeManager）

实现数据在不同组件之间的传递和通信。

```swift
import LWKBCommonUtils_swift

// 创建数据管道管理器
let pipeManager = LWDataPipeManager.shared

// 注册数据接收器
pipeManager.register(for: "userInfo") { data in
    if let userInfo = data as? [String: Any] {
        print("接收到用户信息: \(userInfo)")
    }
}

// 发送数据
pipeManager.send(data: ["name": "John", "age": 30], to: "userInfo")

// 注销数据接收器
pipeManager.unregister(for: "userInfo")
```

高级用法：

```swift
import LWKBCommonUtils_swift

// 使用闭包链式调用
LWDataPipeManager.shared
    .register(for: "event1") { data in
        print("Event 1: \(data)")
    }
    .register(for: "event2") { data in
        print("Event 2: \(data)")
    }

// 广播数据到所有接收器
pipeManager.broadcast(data: "Global notification")

// 清除所有接收器
pipeManager.clearAll()
```

### 3. SwiftUI 扩展（SwiftUIExtensions）

提供了丰富的 SwiftUI 视图扩展。

#### 视图修饰符

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
                .background(Color.blue)

            // 条件修饰符
            Text("Conditional Style")
                .if(someCondition) { view in
                    view.foregroundColor(.red)
                }
        }
    }
}
```

#### 颜色扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

// 从十六进制创建颜色
let color1 = Color(hex: "#FF5733")
let color2 = Color(hex: "3498DB")

// 从 RGB 创建颜色
let color3 = Color(red: 255, green: 87, blue: 51)

// 颜色预设
let primaryColor = Color.appPrimary
let secondaryColor = Color.appSecondary
let backgroundColor = Color.appBackground
```

#### 视图扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    var body: some View {
        VStack {
            // 隐藏视图
            Text("Hidden text")
                .hidden(condition: true)

            // 圆角特定边
            Rectangle()
                .fill(Color.blue)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .frame(width: 200, height: 100)

            // 添加边框
            Text("Bordered")
                .border(Color.red, width: 2, cornerRadius: 8)
        }
    }
}
```

#### 布局扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    var body: some View {
        VStack {
            // 居中对齐
            Text("Centered")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .centered()

            // 填充父视图
            Color.blue
                .fillParent()

            // 固定尺寸
            Circle()
                .size(width: 100, height: 100)
        }
    }
}
```

#### 字体扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Custom Font")
                .font(.custom("HelveticaNeue-Bold", size: 20))

            Text("System Font")
                .font(.system(size: 16, weight: .medium, design: .rounded))

            // 自适应字体
            Text("Adaptive Font")
                .adaptiveFont(size: 18)
        }
    }
}
```

#### 手势扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    var body: some View {
        VStack {
            // 单击手势
            Text("Tap me")
                .onTapGesture {
                    print("Tapped")
                }

            // 长按手势
            Text("Long press")
                .onLongPressGesture(minimumDuration: 1.0) {
                    print("Long pressed")
                }

            // 拖拽手势
            Text("Drag me")
                .onDragGesture { value in
                    print("Dragging: \(value.translation)")
                }
        }
    }
}
```

#### 动画扩展

```swift
import SwiftUI
import LWKBCommonUtils_swift

struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(isAnimating ? 1.5 : 1.0)
                .animation(.spring())

            Button("Animate") {
                withAnimation {
                    isAnimating.toggle()
                }
            }
        }
    }
}
```

### 4. LWKBCommonUtils 核心工具

```swift
import LWKBCommonUtils_swift

// 版本比较
let isNewer = LWKBCommonUtils.compareVersion("2.0.0", with: "1.5.0")

// URL 编码/解码
let encoded = LWKBCommonUtils.urlEncode("Hello World")
let decoded = LWKBCommonUtils.urlDecode(encoded)

// JSON 转换
if let json = LWKBCommonUtils.toJSON(object: someObject) {
    print(json)
}

// 字符串工具
let trimmed = LWKBCommonUtils.trim(" Hello ")
let isEmpty = LWKBCommonUtils.isEmpty(someString)

// 日期格式化
let dateString = LWKBCommonUtils.formatDate(Date(), format: "yyyy-MM-dd HH:mm:ss")

// 文件大小格式化
let sizeString = LWKBCommonUtils.formatFileSize(1024 * 1024 * 5) // "5 MB"
```

## 高级功能

### 自定义配置

```swift
import LWKBCommonUtils_swift

// 扩展 AppDefines
extension AppDefines {
    static var customColor: UIColor {
        return UIColor(red: 0.2, green: 0.4, blue: 0.6, alpha: 1.0)
    }

    static var appName: String {
        return "My App"
    }
}
```

### 数据管道过滤

```swift
import LWKBCommonUtils_swift

// 添加数据过滤器
pipeManager.addFilter(for: "userData") { data in
    // 只处理符合条件的数据
    guard let dict = data as? [String: Any],
          dict["type"] as? String == "user" else {
        return nil
    }
    return data
}
```

## 最佳实践

1. **使用 AppDefines**：统一管理应用常量，避免硬编码
2. **数据管道**：用于跨模块通信，避免紧耦合
3. **SwiftUI 扩展**：提高代码可读性和复用性
4. **内存管理**：及时注销数据接收器，避免内存泄漏

## 注意事项

1. **线程安全**：数据管道管理器是线程安全的
2. **内存泄漏**：使用 weak self 避免循环引用
3. **SwiftUI 兼容性**：某些扩展需要 iOS 13.0+
4. **性能考虑**：避免频繁发送大数据

## Objective-C 版本

如果你的项目使用 Objective-C，请使用原版 LWKBCommonUtils：

```ruby
pod 'LWKBCommonUtils'
```

## 许可证

LWKBCommonUtils_swift 使用 MIT 许可证。详见 LICENSE 文件。
