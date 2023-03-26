import XCTest
@testable import FoundationX
@testable import FoundationX_Objc

final class GHFoundationTests: XCTestCase {
    func testmMethodLock() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FoundationX().text, "Hello, World!")
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
        XLogger.withFlag("🍎", "🍊").printMessage("This is a message with my custom flags and my objc:", obj)
    }
    
    func testMirror() throws {
        let str: String? = ""
        let _str: Any = str
        XLogger.printMessage(Mirror.isOptional(any: _str))
        let str_ = str!
        XLogger.printMessage(Mirror.isOptional(any: str_))
    }
    
    func testThen() throws {
        let _ = NSObject().then { objc in
            XLogger.printMessage(objc)
        }
    }
}
