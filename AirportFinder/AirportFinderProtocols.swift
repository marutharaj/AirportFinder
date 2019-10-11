//
//  AirportFinderProtocols.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit
import AFHandy

protocol AirportViewModelProtocol: class {
    var airportHelper: AirportFinderProtocol! { get set }
    init(airportHelper: AirportFinderProtocol)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath, for cell: UITableViewCell) -> UITableViewCell
}
