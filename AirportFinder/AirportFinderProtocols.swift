//
//  AirportFinderProtocols.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit

protocol AirportViewModelProtocol: class {
    var airports: [Airport] { get set }
    var filteredCityAirports: [Airport] { get set }
    var nearestAirports: [Airport] { get set }
    var shouldShowCities: Bool { get set }
    var didReceiveAirport: ((AirportViewModelProtocol) -> ())? { get set }
    var didFailReceiveAirport: ((Error) -> ())? { get set }
    func getAirports()
    func findNearestAirport(by filteredAirportIndex: Int)
    func filterAirports(by searchText: String)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell
}
