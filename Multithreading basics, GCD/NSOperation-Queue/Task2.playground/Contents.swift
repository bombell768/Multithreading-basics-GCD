import Foundation

func createOperation(named name: String) -> BlockOperation {
    return BlockOperation {
        print("Operation \"\(name)\" started")
        sleep(1)
        print("Operation \"\(name)\" finished")
    }
}

func testOperationQueue() {
    
    print("=== Test 1: maxConcurrentOperationCount = 6 ===")
    let queue1 = OperationQueue()
    queue1.maxConcurrentOperationCount = 6
    queue1.addOperations([createOperation(named: "A"), createOperation(named: "B"), createOperation(named: "C"), createOperation(named: "D")], waitUntilFinished: true)

    print("\n=== Test 2: maxConcurrentOperationCount = 2 ===")
    let queue2 = OperationQueue()
    queue2.maxConcurrentOperationCount = 2
    queue2.addOperations([createOperation(named: "A"), createOperation(named: "B"), createOperation(named: "C"), createOperation(named: "D")], waitUntilFinished: true)
    
    print("\n=== Test 3: Dependencies (B depends on C, D depends on B) ===")
    let queue3 = OperationQueue()
    
    let opA3 = createOperation(named: "A")
    let opB3 = createOperation(named: "B")
    let opC3 = createOperation(named: "C")
    let opD3 = createOperation(named: "D")
    
    opB3.addDependency(opC3)
    opD3.addDependency(opB3)
    
    queue3.addOperations([opA3, opB3, opC3, opD3], waitUntilFinished: true)
    

    print("\n=== Test 4: Dependencies + Low Priority for A ===")
    let queue4 = OperationQueue()
    
    let opA4 = createOperation(named: "A")
    opA4.queuePriority = .low
    let opB4 = createOperation(named: "B")
    let opC4 = createOperation(named: "C")
    let opD4 = createOperation(named: "D")
    
    opB4.addDependency(opC4)
    opD4.addDependency(opB4)
    
    queue4.addOperations([opA4, opB4, opC4, opD4], waitUntilFinished: true)
}

testOperationQueue()
