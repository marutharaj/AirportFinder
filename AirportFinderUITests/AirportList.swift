//
//  AirportList.swift
//  AirportFinderUITests
//
//  Created by mac on 10/5/19.
//

import XCTest

final class AirportList: Screen {
    
    private lazy var searchBar = app.searchFields.element(boundBy: 0)
    private lazy var airportTableView = app.tables["AirportTableView"]
    
    var searchBarExists: Bool {
        //waitFor(searchBar, status: .exist)
        return exists(searchBar, timeout: 32)
    }
    
    var airportTableViewExists: Bool {
        //waitFor(airportTableView, status: .exist)
        return exists(airportTableView, timeout: 32)
    }
    
    var airportNameExists: Bool {
        return exists(airportTableView.staticTexts["Anaa Airport"], timeout: 32)
    }
    
    var scrollAirportNameExists: Bool {
        return exists(airportTableView.staticTexts["Atka Airport"], timeout: 32)
    }
    
    var cityExists: Bool {
         return airportTableView.cells.count == 4
    }
    
    var nearestAirportExists: Bool {
        return airportTableView.cells.count == 5
    }
    
    func tapAirportName(_ airportName: String) {
        airportTableView.staticTexts[airportName].tap()
    }
    
    func tapCityName(_ cityName: String) {
        airportTableView.staticTexts[cityName].tap()
    }
    
    func typeText(_ cityName: String) {
        searchBar.tap()
        searchBar.typeText(cityName)
    }
    
    func scrollTo(_ airportName: String) {
        app.scrollTo(element: airportTableView.staticTexts[airportName])
    }
}
