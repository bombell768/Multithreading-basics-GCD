import Foundation

func testOperationCancellation(withDependency: Bool) {
    let queue = OperationQueue()
    
    let operationB = BlockOperation {
        print("Operation \"B\" started")
        for _ in 0..<1000000 {
            // do nothing
        }
//        sleep(1)
        print("Operation \"B\" finished")
    }
    
    let operationA = BlockOperation {
        print("Operation \"A\" started")
        
        operationB.cancel()
        
        for _ in 0..<1000000 {
            // do nothing
        }
//        sleep(1)
        print("Operation \"A\" finished")
    }
    
    if withDependency {
        operationB.addDependency(operationA)
    }
    
    queue.addOperations([operationA, operationB], waitUntilFinished: true)
    
    print("Test finished (withDependency: \(withDependency))")
}


print("\n=== Test 1: With dependency ===")
testOperationCancellation(withDependency: true)

print("\n=== Test 2: Without dependency ===")
testOperationCancellation(withDependency: false)
