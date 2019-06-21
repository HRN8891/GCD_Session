//
//  WorkItem.swift
//  GCD
//
//  Created by Hiren Patel on 29/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class WorkItem: NSObject {

    var dispatchWorkItem: DispatchWorkItem!
    
    func workingWithTheDispatchWorkItem() {
        
        let dispatchWorkItemQueue = DispatchQueue(label: "com.GCD.dispatchWorkItemQueue")
        
        dispatchWorkItem = DispatchWorkItem { [weak self] in
            for i in 20..<20000 {
                if (self?.dispatchWorkItem.isCancelled)! {
                    print("Operation cancelled")
                    break
                }
                print(i)
            }
        }
        
        dispatchWorkItemQueue.async(execute: dispatchWorkItem)
//       dispatchWorkItem.perform()
//        dispatchWorkItem.wait()
//        let timeOut = DispatchTime.now() + .milliseconds(10)
//        dispatchWorkItem.wait(timeout: timeOut)
//        dispatchWorkItem.cancel()
    }
    
    
    
    
//     func workingWithDispatchWorkItem() {
//
//
//        // Here we are cancelling the task after few second and we will check that the task is valid or not. We have serial queue of several tasks that will executed and if cancelled task than next task will automatically start executing.
//
//
//        let dispatchWorkItemQueue = DispatchQueue(label: "DispatchWorkItem", qos: .userInitiated)
//
//        dispatchWorkItem = DispatchWorkItem { [weak self] in
//            print("Third Operation")
//
//            for i in 20..<200000 {
//                if (self?.dispatchWorkItem.isCancelled)! {
//                    print("Operation cancelled")
//                    break
//                }
//                print(i)
//            }
//        }
//        /*
//         This is example of DispatchWork Item perform. It will be perform in current thread...
//         dispatchWorkItem = DispatchWorkItem.init(qos: .background, flags: .detached) { [weak self] in
//         for i in 20..<2000000 {
//         if (self?.dispatchWorkItem.isCancelled)! {
//         print("Operation cancelled")
//         break
//         }
//         print(i)
//         }
//         }
//         dispatchWorkItem.perform()*/
//
//        dispatchWorkItemQueue.async(execute: dispatchWorkItem)
//
//
//        let  secondDispatchWorkItem = DispatchWorkItem {
//            print("secondDispatchWorkItem Operation")
//        }
//        dispatchWorkItemQueue.async(execute: secondDispatchWorkItem)
//
//
//        let  thirdDispatchWorkItem = DispatchWorkItem {
//            print("thirdDispatchWorkItem Operation")
//        }
//        dispatchWorkItemQueue.async(execute: thirdDispatchWorkItem)
//
//
//        let deadline = DispatchTime.now() + .milliseconds(100)
//
//
//        /*
//         // This section describe use of wait function in DispatchWorkItem and we can also implement the same cancel logic with it.
//         //dispatchWorkItem.wait()
//         _ = dispatchWorkItem.wait(timeout: deadline)
//         self.dispatchWorkItem.cancel()
//         */
//
//
//        DispatchQueue.main.asyncAfter(deadline: deadline) {[weak self] in
//            self?.dispatchWorkItem.cancel()
//        }
//    }
    
}
