//
//  ConcurrentQueue.swift
//  GCD
//
//  Created by Hiren Patel on 29/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class ConcurrentQueue: NSObject {

    var inactiveQueue: DispatchQueue!
    
    
    func qosIntroduction()  {
        
        let firstQueue = DispatchQueue(label: "com.gcd.firstQueue", qos: .background)
        let secondQueue = DispatchQueue(label: "com.gcd.secondQueue", qos: .userInitiated)

        firstQueue.async {
            for i in 10...20{
                print("🔷", i)
                
            }
        }
        
        secondQueue.async {
            for i in 10...20{
                print("🔴", i)
            }
        }
}
    
    func performConcurrentQueue()  {
        
        let concurrentQueue = DispatchQueue(label: "com.gcd.concurrent", qos: .utility, attributes: [.concurrent, .initiallyInactive] )
        
        
//        let concurrentQueueBackground = DispatchQueue(label: "com.gcd.concurrentQueueBackground", qos: .userInteractive, attributes: [.concurrent] )

        inactiveQueue = concurrentQueue
        
        concurrentQueue.async {
            for i in 1000..<1100 {
                print("⚫️", i)
            }
        }
        
        concurrentQueue.async {
            for i in 10...20{
                print("🔷", i)
                
            }
        }
        
        concurrentQueue.async {
            for i in 10...20{
                print("🔴", i)
            }
        }
        
        concurrentQueue.async {
            for i in 1000..<1010 {
                print("⚪️", i)
            }
        }
    }
    

    
    
    func concurrentQueuesWithMutipleApi() {
        
        let concurrentQueue = DispatchQueue(label: "com.gcd.concurrent", qos: .utility, attributes: [.concurrent])
        
         inactiveQueue = concurrentQueue
        
        concurrentQueue.async {
            
            ApiManager.shared.searchWithResult(searchText: "Griddle", completion: { (brands, error) in
                if brands != nil {
                    if let brandDetails = brands! ["branded"] {
                        print("Total Result for  Griddle is \(String(describing: brandDetails.count))")
                    }
                } else {
                    print("Total Result for  Griddle is eroor)")
                }
            })
        }
        
        concurrentQueue.async {
            ApiManager.shared.searchWithResult(searchText: "Pizza", completion: { (brands, error) in
                if brands != nil {
                    if let brandDetails = brands! ["branded"] {
                        print("Total Result for  Pizza is \(String(describing: brandDetails.count))")
                    }
                } else {
                    print("Total Result for  Pizza is eroor)")
                }
            })
        }
        
        concurrentQueue.async {

            ApiManager.shared.searchWithResult(searchText: "Test", completion: { (brands, error) in
                if brands != nil {
                    if let brandDetails = brands! ["branded"] {
                        print("Total Result for  Test is \(String(describing: brandDetails.count))")
                    }
                } else {
                    print("Total Result for  Test is eroor)")
                }
            })
        }
        
        concurrentQueue.async {
            
            ApiManager.shared.searchWithResult(searchText: "Burger", completion: { (brands, error) in
                if brands != nil {
                    if let brandDetails = brands! ["branded"] {
                        print("Total Result for  Burger is \(String(describing: brandDetails.count))")
                    }
                } else {
                    print("Total Result for  Burger is eroor)")
                }
            })
        }
    }
    
}
