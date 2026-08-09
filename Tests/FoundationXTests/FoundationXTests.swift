import XCTest
@testable import FoundationX
@testable import FoundationXObjc

final class GHFoundationTests: XCTestCase {
    func testmMethodLock() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssert(lockFunc() != nil)
        XMethodLock(self, #selector(lockFunc))
        XLogger.log(XMethodIsLocked(self, #selector(lockFunc)))
        XCTAssert(lockFunc() == nil)
        XMethodUnlock(self, #selector(lockFunc))
        XLogger.log(XMethodIsLocked(self, #selector(lockFunc)))
    }

    @objc func lockFunc() -> Any? {
        if XMethodIsLocked(self, #selector(lockFunc)) {
            return nil
        }
        return "called"
    }

    func testLogger() throws {
        XLogger.log("Hello!", "Logger")
        let obj = NSObject()
        XLogger.log("This is a message with my custom flags and my objc:", obj, flags: ["🍎", "🍊"])

        let contextualMessage = XLogger.formattedMessage(
            message: "Hello",
            flags: ["auth"],
            pure: false,
            fileID: "FoundationXTests/LoggerTests.swift",
            function: "testLogger()",
            line: 28,
            timestamp: "2026-08-09 18:00:00"
        )
        XCTAssertEqual(contextualMessage, "◎ auth 2026-08-09 18:00:00 - LoggerTests.swift.testLogger() [line 28]\n╰─> Hello")

        let pureMessage = XLogger.formattedMessage(
            message: "Only the message",
            flags: ["ignored"],
            pure: true,
            fileID: "LoggerTests.swift",
            function: "testLogger()",
            line: 32,
            timestamp: "2026-08-09 18:00:00"
        )
        XCTAssertEqual(pureMessage, "Only the message")
    }

    func testLoggerEvaluatesSingleMessagesLazily() {
        var didEvaluate = false
        func makeMessage() -> String {
            didEvaluate = true
            return "Lazy message"
        }

        XLogger.log(makeMessage(), pure: true)

        #if DEBUG
        XCTAssertTrue(didEvaluate)
        #else
        XCTAssertFalse(didEvaluate)
        #endif
    }

    func testMirror() throws {
        let optionalString: String? = ""
        let optionalAsAny: Any = optionalString as Any
        XLogger.log(Mirror.isOptional(optionalAsAny))
        let string = try XCTUnwrap(optionalString)
        XLogger.log(Mirror.isOptional(string))
    }

    func testThen() throws {
        _ = NSObject().then { objc in
            XLogger.log(objc)
        }
    }

    func testArraySafe() throws {
        let arr: [Int] = [0]
        XLogger.log(arr[safe: 100] as Any) // output: nil
    }

    func testStringIndex() throws {
        XCTAssertEqual("hello"[1], "e")
        XCTAssertNil("world"[-1])
        XCTAssertNotNil("world"[0])
        XCTAssertEqual("world"[3].stringValue, "l")
        XCTAssertEqual("world"[3]?.stringValue, "l")
        XLogger.log("world"[1].stringValue)
    }

    func testTrim() throws {
        let str = "\n Hello   \n"
        let trimmed = str.trimWhitespacesAndNewlines()
        XCTAssertEqual(trimmed, "Hello")
    }

    func testCharacter() throws {
        let str = "Hello"
        let chr = str[2]
        XCTAssertEqual(chr, Character("l"))
    }

    func testCharacterConvert() throws {
        let chr: String = Character("H").stringValue
        XCTAssertEqual(chr, "H")
    }

    @MainActor
    func testDeviceManager() throws {
        #if os(macOS)
        XLogger.log(DeviceManager.shared.macAddresses,
                             DeviceManager.shared.serialNumber,
                             DeviceManager.shared.appVersion,
                             DeviceManager.shared.buildNumber,
                             DeviceManager.shared.systemVersion
        )
        XCTAssertTrue(!DeviceManager.shared.macAddresses.isEmpty)
        XCTAssertTrue(!DeviceManager.shared.serialNumber.isEmpty)
        #endif
    }
}
