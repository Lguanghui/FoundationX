# FoundationX

[![Lint & Test](https://github.com/Lguanghui/FoundationX/actions/workflows/swift.yml/badge.svg)](https://github.com/Lguanghui/FoundationX/actions/workflows/swift.yml)
[![codecov](https://codecov.io/gh/Lguanghui/FoundationX/branch/master/graph/badge.svg?token=PK0QQMTIWW)](https://codecov.io/gh/Lguanghui/FoundationX)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Lguanghui/FoundationX)

FoundationX is a small Swift and Objective-C utility library for everyday Foundation-layer work: safer collection access, Codable helpers, file-size utilities, lightweight logging, app/device metadata, and a handful of Objective-C runtime macros.

## Requirements

- Swift 6.2+
- iOS 13.0+
- macOS 14.0+

## Installation

### Swift Package Manager

Add FoundationX to your package dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/Lguanghui/FoundationX.git", from: "0.9.0")
]
```

Then add the product to your target:

```swift
.target(
    name: "YourTarget",
    dependencies: ["FoundationX"]
)
```

### CocoaPods

```ruby
pod 'FoundationX'
```

## What's Included

- Swift extensions for `Array`, `String`, `Optional`, `Mirror`, `DispatchQueue`, `FileManager`, and `URL`.
- Codable utilities including `AnyCodable`, `AnyEncodable`, `AnyDecodable`, default-value property wrappers, and `Encodable.dictionary`.
- `XLogger` for lightweight debug logging with timestamps, source context, and custom flags.
- `DeviceManager` for app version, build number, app name, system version, and macOS device identifiers.
- Objective-C helpers for method locking, swizzling, URL file sizes, URL parameter replacement, target checks, weak/strong macros, and safe block execution.

## Usage

### Safe Collection and String Access

```swift
import FoundationX

let numbers = [1, 2, 3]
numbers[safe: 10]        // nil

let word = "Foundation"
word[0]                  // Optional("F")
word[-1]                 // nil

let value: String? = ""
value.isNilOrEmpty       // true

"\n Hello \n".trimWhitespacesAndNewlines() // "Hello"
```

### URL Query Helpers

```swift
let url = "https://example.com/search"
let result = url.urlAddComponents(from: ["q": "FoundationX"])

// https://example.com/search?q=FoundationX
```

### Codable Defaults

Use default-value wrappers when server payloads may omit fields, return `null`, or send a compatible-but-different type.

```swift
import FoundationX

struct User: Codable, Sendable {
    @DefaultEmptyString var name: String
    @DefaultTrue var isActive: Bool
    @DefaultIntZero var score: Int
    @DefaultEmptyArray var tags: [String]
}
```

Bool defaults also accept compatible integer and string values during decoding:

```swift
struct Feature: Codable, Sendable {
    @DefaultFalse var enabled: Bool
}
```

### Type-Erased Codable Values

```swift
let payload: [String: AnyCodable] = [
    "name": "FoundationX",
    "count": 1,
    "enabled": true,
    "items": [AnyCodable("swift"), AnyCodable("objc")]
]

let raw = payload.rawValue
let data = try JSONEncoder().encode(payload)
```

### Encodable to Dictionary

```swift
struct Profile: Encodable {
    let name: String
    let website: String
}

let dictionary = Profile(
    name: "Guanghui Liang",
    website: "https://github.com/Lguanghui"
).dictionary
```

### Logging

```swift
XLogger.log("User signed in", flags: ["auth"])
XLogger.log("Only the message", pure: true)
```

In debug builds, logs include timestamp, file/function context, and line information.

### Device and App Metadata

```swift
@MainActor
func printDeviceInfo() {
    let device = DeviceManager.shared

    XLogger.log(
        device.appName,
        device.appVsersion,
        device.buildNumber,
        device.systemVersion
    )
}
```

On macOS, `DeviceManager` also exposes `macAddresses` and `serialNumber`.

### File Utilities

```swift
let fileSize = URL(fileURLWithPath: "/path/to/file").fileSize()
let appSize = FileManager.default.applicationSize()
```

On macOS, security-scoped bookmarks can be saved and restored:

```swift
url.saveBookmarkData(for: "selected-folder")
let restored = URL.restoreFileAccess(key: "selected-folder")
```

### Dispatch Once

```swift
@MainActor
func configureOnce() {
    DispatchQueue.once(token: "com.example.configure") {
        XLogger.log("Configured once")
    }
}
```

## Objective-C Helpers

FoundationX also ships Objective-C headers through the `FoundationX_Objc` target.

```objc
#import <FoundationX/XCommonDefines.h>
#import <FoundationX/XMethodLock.h>
#import <FoundationX/NSObject+Swizzle.h>
#import <FoundationX/NSString+X.h>
#import <FoundationX/NSURL+File.h>
```

Examples:

```objc
XWeak(self);
dispatch_main_async_safe(^{
    XStrong(self);
    XBlock_exec(completion, self);
});

if (NSStringCheck(value)) {
    DLog(@"%@", value);
}
```

```objc
- (void)loadData {
    XMethodLockedReturn();

    // Work that should not be re-entered.

    XMarcoUnLock();
}
```

## Development

Run the Swift package tests:

```sh
swift test
```

Run CocoaPods lint:

```sh
pod lib lint --allow-warnings
```

## License

FoundationX is available under the MIT license. See [LICENSE](LICENSE) for details.
