import XCTest
@testable import FoundationX
@testable import FoundationX_Objc

final class GHFoundationTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FoundationX().text, "Hello, World!")
        XMethodLock(self, #selector(lockFunc))
        print(XMethodIsLocked(self, #selector(lockFunc)))
        XMethodUnlock(self, #selector(lockFunc))
        print(XMethodIsLocked(self, #selector(lockFunc)))
    }
    
    @objc func lockFunc() {
        
    }
    
    func testLogger() throws {
        XLogger.printMessage("Hello!", "Logger")
        let obj = NSObject()
        XLogger.withFlag("🍎", "🍊").printMessage("This is a message with my custom flags and my objc:", obj)
    }
}
