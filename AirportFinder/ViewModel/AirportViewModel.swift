//
//  AirportViewModel.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit
import CoreLocation
import AFHandy

class AirportViewModel: AirportViewModelProtocol {
    
    var airportHelper: AirportFinderProtocol!
    
    required init(airportHelper: AirportFinderProtocol) {
        self.airportHelper = airportHelper
    }
    
    // MARK: - Airport table data provider

    func numberOfSections() -> Int {
        
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        
        return airportHelper.shouldShowCities ? airportHelper.filteredCityAirports.count : airportHelper.nearestAirports.count
    }
    
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell {
        
        if airportHelper.shouldShowCities {
            let airport = airportHelper.filteredCityAirports[indexPath.row]
            cell.textLabel?.text = airport.city
        } else {
            let airport = airportHelper.nearestAirports[indexPath.row]
            cell.textLabel?.text = airport.name
        }
        
        return cell
    }
}
