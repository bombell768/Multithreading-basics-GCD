//
//  NSOperationQueueTests.swift
//  Multithreading basics, GCD
//
//  Created by Bartosz Strzecha on 30/07/2025.
//

import Foundation

class NSOperationQueueTests {
    let customQueue = OperationQueue()
    
    func runOperation(useMainQueue: Bool = false) {
        let operationA = BlockOperation {
            print("Operation \"A\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished")
        }
        
        let selectedQueue = useMainQueue ? OperationQueue.main : customQueue
        selectedQueue.addOperation(operationA)
    }
}
