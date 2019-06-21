//
//  Throttler.swift
//  GCD
//
//  Created by Hiren Patel on 05/06/18.
//  Copyright © 2018 Hiren Patel. All rights reserved.
//

import UIKit
import Foundation

public class Throttler {
    
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Int
    static var taskAddedCount = 0
    static var taskExecutedCount = 0
    
    init(seconds: Int) {
        self.maxInterval = seconds
    }
    
    
    func throttler(searchText: String, completion:@escaping (_ brands: [String: AnyObject]?, _ error: Error?) -> ()) {
        job.cancel()
        //print("Previous Job cancel")
      //  print("Task Added")

//        Throttler.taskAddedCount = Throttler.taskAddedCount + 1
        
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            print("Task Executed for \(searchText)")
//            Throttler.taskExecutedCount = Throttler.taskExecutedCount + 1
            ApiManager.shared.searchWithResult(searchText: searchText, completion: { (brands, error) in
                completion(brands, error)
            })
        }
        
        queue.asyncAfter(deadline: .now() + Double(maxInterval), execute: job)

//        let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
//        print("Task Execution count \(Throttler.taskExecutedCount)")
//        print("Task taskAddedCount count \(Throttler.taskAddedCount)")
//        job.notify(queue: DispatchQueue.main) {
//           // print("Task Executed SuccessFully")
//        }
        //print("Next Task for added for \(searchText)")
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Int {
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
}
