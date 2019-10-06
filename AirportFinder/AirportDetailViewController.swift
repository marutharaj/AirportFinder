//
//  AirportDetailViewController.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import UIKit

class AirportDetailViewController: UIViewController {
    
    var airport: Airport?
    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet weak var runwayLengthLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var directFlightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupAccessibilityLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension AirportDetailViewController {
    
    fileprivate func setupAccessibilityLabel() {
        runwayLengthLabel.accessibilityLabel = "AirportRunwayLengthLabel"
        cityLabel.accessibilityLabel = "AirportCityLabel"
        stateLabel.accessibilityLabel = "AirportStateLabel"
        countryLabel.accessibilityLabel = "AirportCountryLabel"
        timeZoneLabel.accessibilityLabel = "AirportTimeZoneLabel"
        directFlightLabel.accessibilityLabel = "AirportDirectFlightLabel"
    }
    
    fileprivate func setupView() {
        
        if let topItem = navigationBar?.topItem,
            let airport = airport {
            
            topItem.title = airport.name

            runwayLengthLabel.attributedText = attributedString(boldText: "Runway Length: ", normalText: airport.runwayLength )
            cityLabel.attributedText = attributedString(boldText: "City: ", normalText: airport.city )
            stateLabel.attributedText = attributedString(boldText: "State: ", normalText: airport.state )
            countryLabel.attributedText = attributedString(boldText: "Country: ", normalText: airport.country )
            timeZoneLabel.attributedText = attributedString(boldText: "Time Zone: ", normalText: airport.timezone )
            directFlightLabel.attributedText = attributedString(boldText: "Direct Flights: ", normalText: airport.directFlights )
        }
    }
    
    fileprivate func attributedString(boldText: String, normalText: String) -> NSMutableAttributedString {
        
        let boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        
        let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let normalString = NSMutableAttributedString(string: normalText, attributes: normalAttributes)
        
        attributedString.append(normalString)
        return attributedString
    }
}

extension AirportDetailViewController {
    
    @IBAction func airportsButtonAction(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
