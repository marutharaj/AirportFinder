//
//  XCUITestCase.swift
//  AirportFinderUITests
//
//  Created by mac on 10/4/19.
//

import XCTest

class XCUITestCase: XCTestCase {
    
    var hybridUpgradeEnabled = false
    
    internal var airportFinderApp: Screen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        if super.testRun!.failureCount > 0 {
            takeScreenshotOf(testCase: super.testRun!.test.debugDescription)
        }
        super.tearDown()
    }
}

extension XCUITestCase {
    
    func given(_ text: String, step: () -> Void ) {
        step()
        airportFinderApp = TestBuilder.resetAndlaunch()
        XCTContext.runActivity(named: "Given " + text) { _ in }
    }
    
    func when(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "When " + text) { _ in
            step()
        }
    }
    
    func then(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "Then " + text) { _ in
            step()
        }
    }
    
    func and(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "And " + text) { _ in
            step()
        }
    }
}
