//
//  AirportDetail.swift
//  AirportFinderUITests
//
//  Created by mac on 10/5/19.
//

import XCTest

final class AirportDetail: Screen {
    
    private lazy var runwayLengthLabel = app.staticTexts["AirportRunwayLengthLabel"]
    private lazy var cityLabel = app.staticTexts["AirportCityLabel"]
    private lazy var stateLabel = app.staticTexts["AirportStateLabel"]
    private lazy var countryLabel = app.staticTexts["AirportCountryLabel"]
    private lazy var timeZoneLabel = app.staticTexts["AirportTimeZoneLabel"]
    private lazy var directFlightLabel = app.staticTexts["AirportDirectFlightLabel"]
    
    var runwayLengthLabelExists: Bool {
        return exists(runwayLengthLabel, timeout: 5)
    }
    
    var cityLabelExists: Bool {
        return exists(cityLabel, timeout: 5)
    }
    
    var stateLabelExists: Bool {
        return exists(stateLabel, timeout: 5)
    }
    
    var countryLabelExists: Bool {
        return exists(countryLabel, timeout: 5)
    }
    
    var timeZoneLabelExists: Bool {
        return exists(timeZoneLabel, timeout: 5)
    }
    
    var directFlightLabelExists: Bool {
        return exists(directFlightLabel, timeout: 5)
    }
    
    func tapBackButton() {
        app.navigationBars.buttons["< Airports"].tap()
    }
}
