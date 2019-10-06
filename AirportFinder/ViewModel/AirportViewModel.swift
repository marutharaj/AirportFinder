//
//  AirportViewModel.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit
import CoreLocation

class AirportViewModel: AirportViewModelProtocol {
    
    var airports = [Airport]()
    var filteredCityAirports = [Airport]()
    var shouldShowCities = false

    var nearestAirports = [Airport]() {
        didSet {
            shouldShowCities = false
            self.didReceiveAirport?(self)
        }
    }
    
    var didReceiveAirport: ((AirportViewModelProtocol) -> ())?
    var didFailReceiveAirport: ((Error) -> ())?
}

extension AirportViewModel {
    
    func getAirports() {
        
        let airportAPI = AirportHelper()
        
        airportAPI.getAirports()
            .done { airports in
                self.airports = airports.filter { !$0.name.isEmpty && !$0.runwayLength.isEmpty }
                self.nearestAirports = self.airports
            }
            .catch { error in
                self.didFailReceiveAirport?(error)
        }
    }
    
    func findNearestAirport(by filteredAirportIndex: Int) {
        
        let selectedCityAirport = filteredCityAirports[filteredAirportIndex]
        
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

extension AirportViewModel {
    
    func numberOfSections() -> Int {
        
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        
        return shouldShowCities ? filteredCityAirports.count : nearestAirports.count
    }
    
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell {
        
        if shouldShowCities {
            let airport = filteredCityAirports[indexPath.row]
            cell.textLabel?.text = airport.city
        } else {
            let airport = nearestAirports[indexPath.row]
            cell.textLabel?.text = airport.name
        }
        
        return cell
    }
}
