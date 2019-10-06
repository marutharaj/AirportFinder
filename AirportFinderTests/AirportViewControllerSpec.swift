//
//  AirportViewControllerSpec.swift
//  AirportFinderTests
//
//  Created by mac on 10/4/19.
//

import Foundation
import Quick
import Nimble

@testable import AirportFinder

class AirportViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: AirportViewController?
        
        describe("Verify AirportViewController") {
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "AirportViewController") as? AirportViewController
                
                subject?.airportTableView = UITableView(frame: CGRect.zero)
                subject?.viewModel = AirportViewModel()
                let airportAPI = MockAirportHelper()
                subject?.viewModel.airports = airportAPI.getAirports().value ?? []
                subject?.viewModel.nearestAirports = subject?.viewModel.airports ?? []
            }
            
            context("When setting up the data") {
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match total airports count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.viewModel.nearestAirports.count
                }
                
                it("Should return a UITableViewCell with airport name") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(airportCell).toNot(beNil())
                    expect(airportCell?.textLabel?.text).to(equal(subject?.viewModel.nearestAirports[0].name))
                }
            }
            
            context("When search city") {
                
                beforeEach {
                    subject?.viewModel.filterAirports(by: "Dub")
                }
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match cities count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.viewModel.filteredCityAirports.count
                }
                
                it("Should return a UITableViewCell with city") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let cityCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(cityCell).toNot(beNil())
                    expect(cityCell?.textLabel?.text).to(equal(subject?.viewModel.filteredCityAirports[0].city))
                }
            }
            
            context("When select city") {
                
                beforeEach {
                    subject?.viewModel.filterAirports(by: "Dub")
                    subject?.viewModel.findNearestAirport(by: 3)
                }
                
                it("Should return correct number of sections") {
                    expect(subject?.viewModel.numberOfSections()) == 1
                }
                
                it("Should match nearest airports count with number of rows") {
                    expect(subject?.viewModel.numberOfRows(in: 0)) == subject?.viewModel.nearestAirports.count
                }
                
                it("Should return a UITableViewCell with airport name") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "airportCellId")
                    let airportCell = subject?.viewModel.cellForRowAt(indexPath: indexPath, for: cell)
                    expect(airportCell).toNot(beNil())
                    expect(airportCell?.textLabel?.text).to(equal(subject?.viewModel.nearestAirports[0].name))
                }
            }
        }
    }
}
