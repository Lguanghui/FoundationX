import XCTest
@testable import FoundationX

final class GHFoundationTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FoundationX().text, "Hello, World!")
        methodLock(object: self, selector: #selector(lockFunc))
        print(methodIsLocked(object: self, selector: #selector(lockFunc)))
        methodUnlock(object: self, selector: #selector(lockFunc))
        print(methodIsLocked(object: self, selector: #selector(lockFunc)))
    }
    
    @objc func lockFunc() {
        
    }
    
    func testLogger() throws {
        Logger.printMessage("Hello!", "Logger")
        let obj = NSObject()
        Logger.withFlag("🍎", "🍊").printMessage("This is a message with my custom flags and my objc:", obj)
    }
}
