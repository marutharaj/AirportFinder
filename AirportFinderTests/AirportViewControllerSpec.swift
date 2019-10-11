//
//  AirportViewControllerSpec.swift
//  AirportFinderTests
//
//  Created by mac on 10/4/19.
//

import Foundation
import Quick
import Nimble
import AFHandy

@testable import AirportFinder

class AirportViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: AirportViewController?
        
        describe("Verify AirportViewController") {
            
            beforeEach {
                let airportService = MockAirportService()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "AirportViewController") as? AirportViewController
                
                subject?.airportTableView = UITableView(frame: CGRect.zero)
                subject?.airportHelper = AirportFinderHelper()
                subject?.viewModel = AirportViewModel(airportHelper: subject?.airportHelper ?? AirportFinderHelper())
                subject?.airportHelper.airports = airportService.getAirports().value ?? []
                subject?.airportHelper.nearestAirports = subject?.airportHelper.airports ?? []
            }
            
            context("When setting up the data") {
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match total airports count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.airportHelper.nearestAirports.count
                }
                
                it("Should return a UITableViewCell with airport name") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(airportCell).toNot(beNil())
                    expect(airportCell?.textLabel?.text).to(equal(subject?.airportHelper.nearestAirports[0].name))
                }
            }
            
            context("When search city") {
                
                beforeEach {
                    subject?.airportHelper.filterAirports(by: "Dub")
                }
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match cities count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.airportHelper.filteredCityAirports.count
                }
                
                it("Should return a UITableViewCell with city") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let cityCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(cityCell).toNot(beNil())
                    expect(cityCell?.textLabel?.text).to(equal(subject?.airportHelper.filteredCityAirports[0].city))
                }
            }
            
            context("When select city") {
                
                beforeEach {
                    subject?.airportHelper.filterAirports(by: "Dub")
                    subject?.airportHelper.findNearestAirport(by: 3)
                }
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match nearest airports count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.airportHelper.nearestAirports.count
                }
                
                it("Should return a UITableViewCell with airport name") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(airportCell).toNot(beNil())
                    expect(airportCell?.textLabel?.text).to(equal(subject?.airportHelper.nearestAirports[0].name))
                }
            }
        }
    }
}
