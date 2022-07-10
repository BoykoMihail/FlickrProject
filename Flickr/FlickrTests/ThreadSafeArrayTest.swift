//
//  ThreadSafeArrayTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 10.07.2022.
//

@testable import Flickr
import XCTest

class ThreadSafeArrayTest: XCTestCase {
    private var threadSafeArray: ThreadSafeArray<Int>!

    override func setUp() {
        super.setUp()

        threadSafeArray = ThreadSafeArray()
    }

    override func tearDown() {
        super.tearDown()

        threadSafeArray = nil
    }

    func testAppendContentsOf() {
        // given
        let expectedCount = 4
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testAppendContentsOfExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]

        // when
        threadSafeArray.append(contentsOf: numbers)
        wait(for: [testAppendContentsOfExpectation], timeout: 1.0)

        // when
        XCTAssertEqual(threadSafeArray.count, expectedCount)
    }
    
    func testAppend() {
        // given
        let expectedCount = 5
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testAppendExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]
        let additionalNumbers = 5
        threadSafeArray.append(contentsOf: numbers)
        
        // when
        threadSafeArray.append(additionalNumbers)
        wait(for: [testAppendExpectation], timeout: 3.0)

        // when
        XCTAssertEqual(threadSafeArray.count, expectedCount)
    }
    
    func testRemoveAll() {
        // given
        let expectedCount = 0
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testRemoveAllExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]
        threadSafeArray.append(contentsOf: numbers)
        
        // when
        threadSafeArray.removeAll()
        wait(for: [testRemoveAllExpectation], timeout: 3.0)

        // when
        XCTAssertEqual(threadSafeArray.count, expectedCount)
    }
    
    func testSubscriptReadNotNil() {
        // given
        let expectedCount = 4
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testSubscriptReadNotNilExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]
        
        // when
        threadSafeArray.append(contentsOf: numbers)
        wait(for: [testSubscriptReadNotNilExpectation], timeout: 3.0)

        // when
        XCTAssertEqual(threadSafeArray[3], 4)
    }
    
    func testSubscriptReadNil() {
        // given
        let expectedCount = 4
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testSubscriptReadNilExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]
        
        // when
        threadSafeArray.append(contentsOf: numbers)
        wait(for: [testSubscriptReadNilExpectation], timeout: 3.0)

        // when
        XCTAssertNil(threadSafeArray[4])
    }
    
    func testSubscriptAdd() {
        // given
        let expectedCount = 4
        let newNumber = 6
        let predicate = NSPredicate { _, _ in
            return self.threadSafeArray.count == expectedCount
        }
        let testSubscriptAddExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: threadSafeArray
        )
        
        let numbers = [1, 2, 3, 4]
        threadSafeArray.append(contentsOf: numbers)

        // when
        threadSafeArray[0] = newNumber
        wait(for: [testSubscriptAddExpectation], timeout: 3.0)

        // when
        XCTAssertEqual(threadSafeArray[0], newNumber)
    }
}
