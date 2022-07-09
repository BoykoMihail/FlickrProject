//
//  ThreadSafeArray.swift
//  Flickr
//
//  Created by m.a.boyko on 02.07.2022.
//

import Foundation
import Metal


final class ThreadSafeArray<Element> {
    
    private let concurrentThreadSafeQueue = DispatchQueue(label: "Thread.concurrent.queue", attributes: .concurrent)

    private var array = Array<Element>()
    
    func removeAll() {
        concurrentThreadSafeQueue.async(flags: .barrier) {
            self.array.removeAll()
        }
    }
    
    func append(_ newElement: Element) {
        concurrentThreadSafeQueue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
    
    func append<S>(contentsOf: S) where S: Sequence, Element == S.Element {
        concurrentThreadSafeQueue.async(flags: .barrier) {
            self.array.append(contentsOf: contentsOf)
        }
    }
    
    var count: Int {
        var count: Int = 0
        
        concurrentThreadSafeQueue.syncIfNotMain {
            count = self.array.count
        }
        
        return count
    }
}


extension ThreadSafeArray {
    subscript(_ i: Int) -> Element? {
        get {
            guard i < count else {
                return nil
            }
            
            var result: Element? = nil
            
            concurrentThreadSafeQueue.syncIfNotMain {
                result = self.array[i]
            }
            
            return result
        }
        
        set {
            guard let newValue = newValue else { return }
            concurrentThreadSafeQueue.async(flags: .barrier) {
                self.array[i] = newValue
            }
        }
    }
}


extension DispatchQueue {
    func syncIfNotMain(execute block: () -> Void) {
        guard !Thread.isMainThread else {
            block()
            return
        }
        
        sync {
            block()
        }
    }
}
