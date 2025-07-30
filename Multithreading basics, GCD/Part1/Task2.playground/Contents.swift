import Foundation

let semaphore = DispatchSemaphore(value: 2)

func performTask(id: Int) {
    semaphore.wait()
    print("Task \(id) started")
    sleep(1)
    print("Task \(id) finished")
    semaphore.signal()
}

func runConcurrentTasks() {
    let threads = (1...5).map { id in
        Thread {
            performTask(id: id)
        }
    }

    threads.forEach { $0.start() }
    
    for thread in threads {
        while thread.isExecuting {
            usleep(200)
        }
    }
}

runConcurrentTasks()
