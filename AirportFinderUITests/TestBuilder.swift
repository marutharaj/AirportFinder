//
//  TestBuilder.swift
//  AirportFinderUITests
//
//  Created by mac on 10/4/19.
//

import XCTest

final class TestBuilder {
    
    static func resetAndlaunch() -> Screen {
        let app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
        return Screen(app)
    }
}
