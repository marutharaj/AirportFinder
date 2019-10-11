//
//  AirportFinderHelper.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreLocation

public class AirportFinderHelper: AirportFinderProtocol {
    
    public var airports = [Airport]()
    public var filteredCityAirports = [Airport]()
    public var shouldShowCities = false
    
    public var nearestAirports = [Airport]() {
        didSet {
            shouldShowCities = false
            self.didReceiveAirport?(self)
        }
    }
    
    public init() {}
    
    public var didReceiveAirport: ((AirportFinderProtocol) -> ())?
    public var didFailReceiveAirport: ((Error) -> ())?
}

public extension AirportFinderHelper {
    
    func getAirports() {
        
        let airportAPI = AirportService()
        
        airportAPI.getAirports()
            .done { airports in
                self.airports = airports.filter { !$0.name.isEmpty && !$0.runwayLength.isEmpty }
                self.nearestAirports = self.airports
            }
            .catch { error in
                self.didFailReceiveAirport?(error)
        }
    }
    
    /// Find top five nearest airport
    /// - Parameters:
    ///   - selectedCityIndex: The selected city index.
    func findNearestAirport(by selectedCityIndex: Int) {
        
        let selectedCityAirport = filteredCityAirports[selectedCityIndex]
        
        let neighbourAirports = airports.filter { airport -> Bool in
            return selectedCityAirport.country == airport.country
            }.sorted(by: {
                $0.location.distance(from: selectedCityAirport.location) < $1.location.distance(from: selectedCityAirport.location)
            })
        
        if neighbourAirports.count > ResultConfig.maxNearestAirport {
            nearestAirports = Array(neighbourAirports[..<ResultConfig.maxNearestAirport])
        } else {
            nearestAirports = neighbourAirports
        }
    }
    
    func filterAirports(by searchText: String) {
        
        if searchText.isEmpty {
            shouldShowCities = false
            nearestAirports = airports
        } else {
            filteredCityAirports = airports.filter { airport -> Bool in
                return airport.city.range(of: searchText, options: .caseInsensitive) != nil
                }.unique()
            
            shouldShowCities = filteredCityAirports.isEmpty ? false : true
            didReceiveAirport?(self)
        }
    }
}
