//
//  Semaphore.swift
//  GCD
//
//  Created by Hiren Patel on 29/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class Semaphore: NSObject {

    let semaphoreLocal = DispatchSemaphore(value: 10)

    override init() {
        
    }
    

    
    
     func workingWithSemaphore() {
        
        
            let dispatchQueue = DispatchQueue(label: "com.SemaphoreSerial.DispatchQueue", attributes: .concurrent)
        
            for i in 1...20 {
            dispatchQueue.async {
            print("Waiting for the resource of image \(i)")
            self.semaphoreLocal.wait()
            print("Image Downloading started \(i)")
//            let data = try? Data(contentsOf: URL.init(string: "http://placehold.it/120x120&text=gcd\(i)")!)
//            print("Downloaded image bytes \(String(describing: data?.count)) for image \(i) ")
             sleep(2)
            print("Image Downloading completed \(i)")
            self.semaphoreLocal.signal()
            }
            }
        
        return;
        
        /// Semaphore with the serial queue...
//          let dispatchQueue = DispatchQueue(label: "com.SemaphoreSerial.DispatchQueue")
        /// Semaphore with the concurrent queue...
//        let dispatchQueue = DispatchQueue(label: "com.SemaphoreConcurrent.DispatchQueue", attributes: .concurrent)
//////
//        let semaphore = DispatchSemaphore(value: 1)
//////
//        dispatchQueue.async {
//            print("Sema wait for block 1")
//            semaphore.wait()
//            Thread.sleep(forTimeInterval: 5)
//            print("Sema block 1 executed")
//            semaphore.signal()
//            print("Sema signal for block 1")
//        }
////
//        dispatchQueue.async {
//            print("Sema wait for block 2")
//            semaphore.wait()
//            Thread.sleep(forTimeInterval: 2)
//            print("Sema block 2 executed")
//            semaphore.signal()
//            print("Sema signal for block 2")
//        }
////
//        dispatchQueue.async {
//            print("Sema wait for block 3")
//            semaphore.wait()
//            print("Sema block 3 executed")
//            semaphore.signal()
//            print("Sema signal for block 3")
//        }
////
//        dispatchQueue.async {
//            print("Sema wait for block 4")
//            semaphore.wait()
//            print("Sema block 4 executed")
//            semaphore.signal()
//            print("Sema signal for block 4")
//        }
        
        
        let higherPriority = DispatchQueue(label: "com.TestGCD.higherPriority", attributes: .concurrent)
        let lowerPriority = DispatchQueue(label: "com.TestGCD.lowerPriority", attributes: .concurrent)
        let thirdPriority = DispatchQueue(label: "com.TestGCD.thirdPriority", attributes: .concurrent)

        self.asyncPrint(queue: lowerPriority, symbol: "🔵")
        self.asyncPrint(queue: thirdPriority, symbol: "🔴")
        self.asyncPrint(queue: higherPriority, symbol: "🔷")
        

//       let deadline = DispatchTime.now() + .milliseconds(10)
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            self.asyncPrint(queue: higherPriority, symbol: "🔷")
//        }
    }
    
    func asyncPrint(queue: DispatchQueue, symbol: String) {
        queue.async { [weak self] in
            print("\(symbol) waiting")
            self?.semaphoreLocal.wait()  // requesting the resource
            for i in 0...10 {
                print(symbol, i)
            }
            
            print("\(symbol) signal")
            self?.semaphoreLocal.signal() // releasing the resource
        }
    }
    
}
