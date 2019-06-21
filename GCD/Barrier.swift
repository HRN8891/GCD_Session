//
//  Barrier.swift
//  GCD
//
//  Created by Hiren Patel on 29/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class Barrier: NSObject {
    
    let dispatchQueueBarrier = DispatchQueue(label: "com.gcd.dispatchQueueBarrier", qos: .userInitiated, attributes: [.concurrent])
    
    func workingWithBarrier() {
        
        dispatchQueueBarrier.async {
            for i in 0..<10000 {
                print("🔴", i)
            }
        }
        
        dispatchQueueBarrier.async {
            for i in 1000..<20000 {
                print("🔷", i)
            }
            sleep(2)
        }
        
        dispatchQueueBarrier.async(flags: .barrier) {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        dispatchQueueBarrier.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
        
        dispatchQueueBarrier.async {
            for i in 1000..<1010 {
                print("🔷", i)
            }
        }
        
        dispatchQueueBarrier.async {
            for i in 1000..<1010 {
                print("⚪️", i)
            }
        }
    }
}
