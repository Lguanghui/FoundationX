import PlaygroundSupport
import FoundationX
import FoundationX_Objc
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

class TestClass {
    @objc func lockFunc() {

    }
}

let test = TestClass()

XMethodLock(test, #selector(TestClass.lockFunc))

print(XMethodIsLocked(test, #selector(TestClass.lockFunc)))

XMethodUnlock(test, #selector(TestClass.lockFunc))

print(XMethodIsLocked(test, #selector(TestClass.lockFunc)))
