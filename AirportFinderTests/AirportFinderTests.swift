//
//  AirportFinderTests.swift
//  AirportFinderTests
//
//  Created by mac on 10/4/19.
//

import XCTest
import AFHandy

@testable import AirportFinder

class AirportFinderTests: XCTestCase {

    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let subject = storyboard.instantiateViewController(withIdentifier: "AirportViewController") as? AirportViewController
    
    override func setUp() {
        let airportService = MockAirportService()

        subject?.airportTableView = UITableView(frame: CGRect.zero)
        subject?.airportHelper = AirportFinderHelper()
        subject?.viewModel = AirportViewModel(airportHelper: subject?.airportHelper ?? AirportFinderHelper())
        
        subject?.airportHelper.airports = airportService.getAirports().value ?? []
        subject?.airportHelper.nearestAirports = subject?.airportHelper.airports ?? []
    }
    
    func testPerformanceWhenLoadAllAirports() {
        self.measure {
            let lastRow = subject!.airportHelper.nearestAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.airportHelper.nearestAirports[lastRow].name)
        }
    }

    func testPerformanceWhenLoadCities() {
        self.measure {
            subject?.airportHelper.filterAirports(by: "Dub")
            
            let lastRow = subject!.airportHelper.filteredCityAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.airportHelper.filteredCityAirports[lastRow].city)
        }
    }
    
    func testPerformanceWhenLoadNearestAirports() {
        self.measure {
            subject?.airportHelper.filterAirports(by: "Dub")
            subject?.airportHelper.findNearestAirport(by: 3)

            let lastRow = subject!.airportHelper.nearestAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.airportHelper.nearestAirports[lastRow].name)
        }
    }
}
