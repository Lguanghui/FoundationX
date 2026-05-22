<a name="unreleased"></a>
## [Unreleased]


<a name="0.9.1"></a>
## [0.9.1] - 2026-05-23

<a name="0.9.0"></a>
## [0.9.0] - 2026-05-22
### Features
- Add DeviceManager.
- Add DeviceManager.
- Add DeviceManager.
- Add appName in DeviceManager
- Add macro support.
- Add macro support.
- Add macro support.
- Rename log API.
- Rename log API.
- Swift 6’s new concurrency feature adaptation.

### Removals
- package: Remove Swift macro target

### Tests
- tests: Run device manager test on main actor


<a name="0.8.0"></a>
## [0.8.0] - 2024-05-19
### Bug Fixes
- Fix XLogger incorrect function name

### Continuous Integration
- Fix CI build.
- Fix CI build.

### Features
- Add String extension for trimming.
- Add URL extensions for file access.


<a name="0.7.1"></a>
## [0.7.1] - 2024-02-25
### Features
- Add DispatchOnce extension for DispatchQueue.
- Add Value Enum.

### Refactoring
- Move some files.


<a name="0.7.0"></a>
## [0.7.0] - 2023-12-31
### Features
- **string:** Add extension for Optional<String> to quickly get the character of a specific index.


<a name="0.6.0"></a>
## [0.6.0] - 2023-12-31
### Features
- **string:** Add String subscript for getting character of specific index.
- **test:** add test cases.

### Refactoring
- Remove test playground.


<a name="0.5.0"></a>
## [0.5.0] - 2023-11-14
### Features
- **logger:** redefine XLogger's API.


<a name="0.4.1"></a>
## [0.4.1] - 2023-11-13
### Bug Fixes
- **version:** fix bump version error
- **test:** fix test error


<a name="0.4.0"></a>
## [0.4.0] - 2023-11-13
### Bug Fixes
- **test:** fix test error ([#8](https://github.com/Lguanghui/FoundationX/issues/8))

### Features
- **swift:** Add extensions for Codable
- **test:** add Codable tests
- **lint:** add Swiftlint support
- **objc:** add Swizzle methods
- **macro:** add macro for getting screen width/height
- **scheme:** add method for adding/replacing params within a NSString.
- **macro:** add safe block exec macro ([#9](https://github.com/Lguanghui/FoundationX/issues/9))
- **Mirror:** rename API

### Legacy Features
- add DictionaryCheck macro


<a name="0.3.3"></a>
## [0.3.3] - 2023-03-26
### Bug Fixes
- **ci:** fix auto Create Release failed

### Features
- **array:** add safe subcript


<a name="0.3.2"></a>
## [0.3.2] - 2023-03-26
### Features
- **file:** add NSURL+File category


<a name="0.3.1"></a>
## [0.3.1] - 2023-03-26
### Features
- **objc:** add target macro & async safe macro


<a name="0.3.0"></a>
## [0.3.0] - 2023-03-25
### Features
- **objc:** add API visibility macro


<a name="0.2.5"></a>
## [0.2.5] - 2023-03-25
### Features
- **objc:** add weak/strong type macro, NSString/NSArray/NSDictionary valid check macro


<a name="0.2.3"></a>
## [0.2.3] - 2023-03-25

<a name="0.2.2"></a>
## [0.2.2] - 2023-03-24

<a name="0.2.1"></a>
## [0.2.1] - 2023-03-24

<a name="0.2.0"></a>
## [0.2.0] - 2023-03-24

<a name="0.1.5"></a>
## [0.1.5] - 2023-03-24

<a name="0.1.4"></a>
## [0.1.4] - 2023-03-24
### Documentation
- **changelg:** add git-chglog config & generate CHANGELOG.md

### Features
- Add pod lint within CI ([#3](https://github.com/Lguanghui/FoundationX/issues/3))
- fix XMethodLock XCTest


<a name="0.1.3"></a>
## [0.1.3] - 2023-03-24
### Features
- CI Action with Codecov ([#2](https://github.com/Lguanghui/FoundationX/issues/2))
- Support newLineMode ([#1](https://github.com/Lguanghui/FoundationX/issues/1))


<a name="0.1.2"></a>
## [0.1.2] - 2023-03-09
### Features
- **pod:** minimum deployment target changed to iOS 11.0


<a name="0.1.1"></a>
## [0.1.1] - 2023-03-09
### Features
- Rename Logger to XLogger, add Objc Support


<a name="0.1.0"></a>
## [0.1.0] - 2023-03-09
### Features
- Add Logger
- Add Logger
- add FileManager extension
- **optional:** add Optional Array extension


<a name="0.0.5"></a>
## [0.0.5] - 2022-11-15
### Features
- **optional:** add Optional String extension


<a name="0.0.4"></a>
## [0.0.4] - 2022-11-09
### Documentation
- modify bump2version cfg


<a name="0.0.2"></a>
## 0.0.2 - 2022-03-23
### Legacy Features
- add file


[Unreleased]: https://github.com/Lguanghui/FoundationX/compare/0.9.1...HEAD
[0.9.1]: https://github.com/Lguanghui/FoundationX/compare/0.9.0...0.9.1
[0.9.0]: https://github.com/Lguanghui/FoundationX/compare/0.8.0...0.9.0
[0.8.0]: https://github.com/Lguanghui/FoundationX/compare/0.7.1...0.8.0
[0.7.1]: https://github.com/Lguanghui/FoundationX/compare/0.7.0...0.7.1
[0.7.0]: https://github.com/Lguanghui/FoundationX/compare/0.6.0...0.7.0
[0.6.0]: https://github.com/Lguanghui/FoundationX/compare/0.5.0...0.6.0
[0.5.0]: https://github.com/Lguanghui/FoundationX/compare/0.4.1...0.5.0
[0.4.1]: https://github.com/Lguanghui/FoundationX/compare/0.4.0...0.4.1
[0.4.0]: https://github.com/Lguanghui/FoundationX/compare/0.3.3...0.4.0
[0.3.3]: https://github.com/Lguanghui/FoundationX/compare/0.3.2...0.3.3
[0.3.2]: https://github.com/Lguanghui/FoundationX/compare/0.3.1...0.3.2
[0.3.1]: https://github.com/Lguanghui/FoundationX/compare/0.3.0...0.3.1
[0.3.0]: https://github.com/Lguanghui/FoundationX/compare/0.2.5...0.3.0
[0.2.5]: https://github.com/Lguanghui/FoundationX/compare/0.2.3...0.2.5
[0.2.3]: https://github.com/Lguanghui/FoundationX/compare/0.2.2...0.2.3
[0.2.2]: https://github.com/Lguanghui/FoundationX/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/Lguanghui/FoundationX/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/Lguanghui/FoundationX/compare/0.1.5...0.2.0
[0.1.5]: https://github.com/Lguanghui/FoundationX/compare/0.1.4...0.1.5
[0.1.4]: https://github.com/Lguanghui/FoundationX/compare/0.1.3...0.1.4
[0.1.3]: https://github.com/Lguanghui/FoundationX/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/Lguanghui/FoundationX/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/Lguanghui/FoundationX/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/Lguanghui/FoundationX/compare/0.0.5...0.1.0
[0.0.5]: https://github.com/Lguanghui/FoundationX/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/Lguanghui/FoundationX/compare/0.0.2...0.0.4
