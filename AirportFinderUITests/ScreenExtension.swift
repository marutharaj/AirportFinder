//
//  ScreenExtension.swift
//  AirportFinderUITests
//
//  Created by mac on 10/5/19.
//

import XCTest

enum UIState: String {
    case exist = "exists == true"
    case notExist = "exists == false"
    case hittable = "isHittable == true"
}

extension Screen {
    
    internal func exists(_ element: XCUIElement, timeout: Int = 20) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: UIState.exist.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
        return (result != .timedOut)
    }
    
    internal func waitFor(_ element: XCUIElement, status: UIState, _ timeout: Int = 20) {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(timeout))
        
        if result == .timedOut {
            XCTFail(expectation.description)
        }
    }
}
