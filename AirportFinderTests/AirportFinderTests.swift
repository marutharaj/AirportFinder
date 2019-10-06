//
//  AirportFinderTests.swift
//  AirportFinderTests
//
//  Created by mac on 10/4/19.
//

import XCTest
@testable import AirportFinder

class AirportFinderTests: XCTestCase {

    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let subject = storyboard.instantiateViewController(withIdentifier: "AirportViewController") as? AirportViewController
    
    override func setUp() {
        subject?.airportTableView = UITableView(frame: CGRect.zero)
        subject?.viewModel = AirportViewModel()
        let airportAPI = MockAirportHelper()
        subject?.viewModel.airports = airportAPI.getAirports().value ?? []
        subject?.viewModel.nearestAirports = subject?.viewModel.airports ?? []
    }
    
    func testPerformanceWhenLoadAllAirports() {
        self.measure {
            let lastRow = subject!.viewModel.nearestAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.viewModel.nearestAirports[lastRow].name)
        }
    }

    func testPerformanceWhenLoadCities() {
        self.measure {
            subject?.viewModel.filterAirports(by: "Dub")
            
            let lastRow = subject!.viewModel.filteredCityAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.viewModel.filteredCityAirports[lastRow].city)
        }
    }
    
    func testPerformanceWhenLoadNearestAirports() {
        self.measure {
            subject?.viewModel.filterAirports(by: "Dub")
            subject?.viewModel.findNearestAirport(by: 3)

            let lastRow = subject!.viewModel.nearestAirports.count - 1
            let indexPath = IndexPath(row: lastRow, section: 0)
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
            let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
            
            XCTAssertTrue(airportCell != nil)
            XCTAssertTrue(airportCell?.textLabel?.text == subject?.viewModel.nearestAirports[lastRow].name)
        }
    }
}
