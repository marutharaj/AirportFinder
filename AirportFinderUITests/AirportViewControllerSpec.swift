//
//  AirportViewControllerSpec.swift
//  AirportFinderUITests
//
//  Created by mac on 10/4/19.
//

import XCTest

class AirportViewControllerSpec: XCUITestCase {
    
    func testLoadAirports() {

        given("Airport finder app installed on the device") {}
        when("I launch airport finder app") {}
        and("I wait for loading airports") {}
        then("I should see the search bar and table view with airport name") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).searchBarExists, "Unable to see search bar")
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).airportTableViewExists, "Unable to see table view")
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).airportNameExists, "Unable to see airport name")
        }
    }
    
    func testAirportList() {

        given("Airport names loaded into table view") {}
        when("I scroll airport names") {
            airportFinderApp.on(screen: AirportList.self).scrollTo("")
        }
        and("I wait for scrolling") {}
        then("I should see the airport name") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).scrollAirportNameExists, "Unable to see airport name")
        }
    }

    func testSearchCity() {

        given("Airport names loaded into table view") {}
        when("I type city in the search field") {
            airportFinderApp.on(screen: AirportList.self).typeText("Dub")
        }
        and("I wait for loading cities") {}
        then("I should see the city name in the table view") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).cityExists, "Unable to filter city")
        }
    }

    func testSelectCity() {

        given("Cities loaded into table view") {}
        when("I select city") {
            airportFinderApp.on(screen: AirportList.self).typeText("Duba")
            airportFinderApp.on(screen: AirportList.self).tapCityName("Dubai")
        }
        then("I should see the nearest airport") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).nearestAirportExists, "Unable to get nearest airports")
        }
    }

    func testAirportDetails() {

        given("Airport names loaded into table view") {}
        when("I tap airport name") {
            airportFinderApp.on(screen: AirportList.self).tapAirportName("Anaa Airport")
        }
        and("I wait for loading airport details") {}
        then("I should see the airport details") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).runwayLengthLabelExists, "Unable to see runway length label")
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).cityLabelExists, "Unable to see city label")
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).stateLabelExists, "Unable to see state label")
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).countryLabelExists, "Unable to see country label")
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).timeZoneLabelExists, "Unable to see time zone label")
            XCTAssertTrue(airportFinderApp.on(screen: AirportDetail.self).directFlightLabelExists, "Unable to see direct flight label")
        }
    }

    func testAirportDetailsBackButton() {
        given("Airport details displayed") {}
        when("I tap back button") {
            airportFinderApp.on(screen: AirportList.self).tapAirportName("Anaa Airport")
            airportFinderApp.on(screen: AirportDetail.self).tapBackButton()
        }
        and("I wait for redirecting to airport list") {}
        then("I should see the search bar and table view with airport name") {
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).searchBarExists, "Unable to see search bar")
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).airportTableViewExists, "Unable to see table view")
            XCTAssertTrue(airportFinderApp.on(screen: AirportList.self).airportNameExists, "Unable to see airport name")
        }
    }
}
