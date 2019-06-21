//
//  SerialQueue.swift
//  GCD
//
//  Created by Hiren Patel on 29/05/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit

class SerialQueue: NSObject {

    
    func syncWork(){
        let northZone = DispatchQueue(label: "perform_task_with_team_north")
        let southZone = DispatchQueue(label: "perform_task_with_team_south")
    
        
        northZone.async {
            for numer in 1...3{ print("North \(numer)")}
        }
        southZone.async {
            for numer in 1...3{ print("South \(numer)") }
        }
    }
    
     func syncAndAsyncQueue() {
        
        /// Run this code with sync and async methods... The value will be printed in async call and in the sync it waits to complete the first and second queue...
        
        let firstQueue = DispatchQueue(label: "queue1")
        let secondQueue = DispatchQueue(label: "queue2")
        
        firstQueue.async {
            for i in 0..<10 {
                print("🔷", i)
            }
            
        }
        
        secondQueue.async {
            for i in 20..<30 {
                print("⚪️", i)
            }
        }
        
        print("Updated now")
    }
    
    
    
    func executeSerialQueue()  {
        
        let serialQueue = DispatchQueue(label: "com.GCD.SerialQueue")
        print("Start")
        serialQueue.async {
            for i in 1000..<1010 {
                print("⚪️", i)
            }
        }
        serialQueue.async {
            for i in 10...20{
                print("🔷", i)
                
            }
        }
        serialQueue.async {
            for i in 1000..<1100 {
                print("⚫️", i)
            }
        }
        serialQueue.async {
            for i in 10...20{
                print("🔴", i)
            }
        }
        print("End")
        
    }
    
    func performSerialQueue()  {
        
        let serialQueue = DispatchQueue(label: "com.GCD.SerialQueue")
        
        serialQueue.async {
            for i in 10...20{
                print("🔷", i)
                
            }
        }
        serialQueue.async {
            for i in 1000..<1100 {
                print("⚫️", i)
            }
        }
        serialQueue.async {
            for i in 10...20{
                print("🔴", i)
            }
        }
        
        let firstDispatchWorkItem = DispatchWorkItem {
            print("firstDispatchWorkItem Task")
        }
        
        
        let secondDispatchWorkItem = DispatchWorkItem {
            print("secondDispatchWorkItem Task")
        }
        
        let thirdDispatchWorkItem = DispatchWorkItem {
            print("thirdDispatchWorkItem Task")
        }
        
        serialQueue.async(execute: firstDispatchWorkItem)
        serialQueue.async(execute: secondDispatchWorkItem)
        serialQueue.async(execute: thirdDispatchWorkItem)

    }
    
//      func serialQueue() {
//        
//        /// Here we have a serialQueue with three difrrent operations. In GCD queue default works as a serial queue. All this operations will be executed sequential order as we add them(FIFO).
//        /// This queue will be helpful where we have sequential process of any activity and they are dependent an each other.
//        let serialQueue = DispatchQueue(label: "com.gcd.serialQueue")
//
//        let firstDipatchWorkItem = DispatchWorkItem {
//            for i in 0..<10 {
//                print("🔷", i)
//            }
//        }
//        
//        firstDipatchWorkItem.notify(queue: DispatchQueue.main) {
//            print("First task is completed")
//        }
//        
//        let secondDipatchWorkItem = DispatchWorkItem {
//            for i in 20..<30 {
//                print("⚪️", i)
//            }
//            
//        }
//        
//        secondDipatchWorkItem.notify(queue: DispatchQueue.main) {
//            print("Second task is completed")
//        }
//        
//        let thirdDipatchWorkItem = DispatchWorkItem {
//            for i in 20..<40 {
//                print("🔴", i)
//            }
//        }
//        
//        thirdDipatchWorkItem.notify(queue: DispatchQueue.main) { 
//            print("Third task is completed")
//        }
//        serialQueue.async(execute: firstDipatchWorkItem)
//        
//        serialQueue.async(execute: secondDipatchWorkItem)
//        
//        serialQueue.async(execute: thirdDipatchWorkItem)
//    }
    
}
