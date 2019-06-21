//
//  ViewController.swift
//  GCD
//
//  Created by Hiren Patel on 25/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit
import Foundation


private var cachedFormatters = [String : DateFormatter]()

extension DateFormatter {
    
    static func cached(withFormat format: String) -> DateFormatter {
        if let cachedFormatter = cachedFormatters[format] { return cachedFormatter }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        cachedFormatters[format] = formatter
        return formatter
    }
    
}
class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    let semaphore = Semaphore()
    let serialQueue = SerialQueue()
    let concurrent = ConcurrentQueue()
    let dispatchWorkItem = WorkItem()
    let dispatchBarrier = Barrier()
    let group = DispatchGroup()

    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let deadLockQueue = DispatchQueue(label: "DeadLockQueue")
        
        deadLockQueue.async {
            deadLockQueue.sync {
                print("sync")
            }
            print("ayc")
        }

//        dispatchBarrier.workingWithBarrier()
//
//        //        concurrent.inactiveQueue.activate()
//
// //       dispatchBarrier.workingWithBarrier()
////        concurrent.inactiveQueue.activate()
//
////        semaphore.workingWithSemaphore()
////        concurrent.inactiveQueue.activate()
//        return
        
        
            /*    /// What is diffrence between sync and async?
             let syncAndAsyncQueue = SerialQueue()
             syncAndAsyncQueue.syncAndAsyncQueue()
             
             /// What is serial queue?
             serialQueue.serialQueue()
             
             /// What is concurrent queue?
             concurrent.concurrentQueues()
             //concurrent.inactiveQueue.activate()
             
             
             /// Working with the DispatchWorkItem...
             dispatchWorkItem.workingWithDispatchWorkItem()
             
             
             // working with barrier....
             dispatchBarrier.workingWithBarrier()*/
            
            //        dispatchBarrier.workingWithBarrier()
            //        /// working with semaphore....
            //      //  semaphore.workingWithSemaphore()
            //
            //
            //        var array = [Int]()
            //
            //        DispatchQueue.global().async {
            //            DispatchQueue.concurrentPerform(iterations: 10) { iter in
            //                let max = 100_000
            //                for iterB in 0 ..< 100_000 {
            //                    var k = 0
            //                    k = k + 1
            //                    let half = max/2
            //                    if iterB == half {
            //                        array.append(iter)
            //                    }
            //                }
            //            }
            //        }
            //
            //        print("Unsafe loop count: \(array.count)")
        
        let concurrentQueue = DispatchQueue(label: "com.gcd.concurrentQueue", qos: .background, attributes: .concurrent)
        
//        let concurrentQueueSecond = DispatchQueue(label: "com.gcd.concurrentQueueSecond", qos: .background, attributes: .concurrent)
//        let concurrentQueueThird = DispatchQueue(label: "com.gcd.concurrentQueueThird", qos: .background, attributes: .concurrent)


        concurrentQueue.async { [weak self] in
            self?.set("Test", forKey: "ABC")

        }
        concurrentQueue.async { [weak self] in
            print(self?.object(forKey: "ABC") ?? "Value is nil")

        }
        
        concurrentQueue.async { [weak self] in
            self?.set("Test1", forKey: "ABC1")

        }
        concurrentQueue.async { [weak self] in
            print(self?.object(forKey: "ABC1") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
            self?.set("Test2", forKey: "ABC2")

        }
        concurrentQueue.async { [weak self] in
            print(self?.object(forKey: "ABC2") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
            self?.set("Test3", forKey: "ABC3")

        }
        concurrentQueue.async { [weak self] in
            print(self?.object(forKey: "ABC3") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
            self?.set("Test4", forKey: "ABC4")

        }
        concurrentQueue.async { [weak self] in
        print(self?.object(forKey: "ABC4") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
        self?.set("Test5", forKey: "ABC5")

        }
        concurrentQueue.async { [weak self] in
        print(self?.object(forKey: "ABC5") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
        self?.set("Test6", forKey: "ABC6")

        }
        concurrentQueue.async { [weak self] in
         print(self?.object(forKey: "ABC6") ?? "Value is nil")

        }
        concurrentQueue.async { [weak self] in
            self?.set("Test7", forKey: "ABC7")

        }
        concurrentQueue.async { [weak self] in
            print(self?.object(forKey: "ABC7") ?? "Value is nil")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    private let serialQueueDictionary = DispatchQueue(label: "serialQueue")
    private let serialQueueForDictionary = DispatchQueue(label: "concurrentQueue", attributes: [.concurrent])

    private var dictionary: [String: Any] = [:]
    
    public func set(_ value: Any, forKey key: String) {
        
        serialQueueForDictionary.async(flags: .barrier) {
            self.dictionary[key] = value
        }

    }
    
    public func object(forKey key: String) -> Any? {
        var result: Any?
        serialQueueForDictionary.sync {
            result = self.dictionary[key]
        }
        // returns after serialQueue is finished operation
        // beacuse serialQueue is run synchronously

        return result
    }
}



