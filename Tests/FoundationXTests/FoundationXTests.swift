import XCTest
@testable import FoundationX
@testable import FoundationX_Objc

final class GHFoundationTests: XCTestCase {
    func testmMethodLock() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssert(lockFunc() != nil)
        XMethodLock(self, #selector(lockFunc))
        XLogger.printMessage(XMethodIsLocked(self, #selector(lockFunc)))
        XCTAssert(lockFunc() == nil)
        XMethodUnlock(self, #selector(lockFunc))
        XLogger.printMessage(XMethodIsLocked(self, #selector(lockFunc)))
    }

    @objc func lockFunc() -> Any? {
        if XMethodIsLocked(self, #selector(lockFunc)) {
            return nil
        }
        return "called"
    }

    func testLogger() throws {
        XLogger.printMessage("Hello!", "Logger")
        let obj = NSObject()
        XLogger.printMessage("This is a message with my custom flags and my objc:", obj, flags: ["🍎", "🍊"])
    }

    func testMirror() throws {
        let str: String? = ""
        let _str: Any = str
        XLogger.printMessage(Mirror.isOptional(_str))
        let str_ = str!
        XLogger.printMessage(Mirror.isOptional(str_))
    }

    func testThen() throws {
        _ = NSObject().then { objc in
            XLogger.printMessage(objc)
        }
    }
    
    func testArraySafe() throws {
        let arr: [Int] = [0]
        XLogger.printMessage(arr[safe: 100]) // output: nil
    }
    
    func testStringIndex() throws {
        XCTAssertEqual("hello"[1], "e")
        XCTAssertNil("world"[-1])
        XCTAssertNotNil("world"[0])
        XCTAssertEqual("world"[3].stringValue, "l")
        XCTAssertEqual("world"[3]?.stringValue, "l")
        XLogger.printMessage("world"[1].stringValue)
    }
}
