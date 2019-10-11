//
//  AFHandyProtocols.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

public protocol AirportFinderProtocol: class {
    var airports: [Airport] { get set }
    var filteredCityAirports: [Airport] { get set }
    var nearestAirports: [Airport] { get set }
    var shouldShowCities: Bool { get set }
    var didReceiveAirport: ((AirportFinderProtocol) -> ())? { get set }
    var didFailReceiveAirport: ((Error) -> ())? { get set }
    func getAirports()
    func findNearestAirport(by selectedCityIndex: Int)
    func filterAirports(by searchText: String)
}
