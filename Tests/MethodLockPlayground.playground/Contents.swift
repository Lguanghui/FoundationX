import PlaygroundSupport
import FoundationX
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

class TestClass {
    @objc func lockFunc() {
        
    }
}

let test = TestClass()

methodLock(object: test, selector: #selector(TestClass.lockFunc))

print(methodIsLocked(object: test, selector: #selector(TestClass.lockFunc)))

methodUnlock(object: test, selector: #selector(TestClass.lockFunc))

print(methodIsLocked(object: test, selector: #selector(TestClass.lockFunc)))

