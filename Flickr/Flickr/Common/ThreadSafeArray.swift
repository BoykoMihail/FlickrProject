//
//  ThreadSafeArray.swift
//  Flickr
//
//  Created by m.a.boyko on 02.07.2022.
//

import Foundation
import Metal


final class ThreadSafeArray<Element> {
    
    private let concurrentCashQueue = DispatchQueue(label: "gallerypresenter.concurrent.cash.queue", attributes: .concurrent)

    private var array = Array<Element>()
    
    func removeAll() {
        concurrentCashQueue.async(flags: .barrier) {
            self.array.removeAll()
        }
    }
    
    func append(_ newElement: Element) {
        concurrentCashQueue.async(flags: .barrier) {
            self.array.append(newElement)
        }
    }
    
    func append<S>(contentsOf: S) where S: Sequence, Element == S.Element {
        concurrentCashQueue.async(flags: .barrier) {
            self.array.append(contentsOf: contentsOf)
        }
    }
    
    var count: Int {
        var count: Int = 0
        
        concurrentCashQueue.sync {
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
            
            concurrentCashQueue.sync {
                result = self.array[i]
            }
            
            return result
        }
        
        set {
            guard let newValue = newValue else { return }
            concurrentCashQueue.async(flags: .barrier) {
                self.array[i] = newValue
            }
        }
    }
}
