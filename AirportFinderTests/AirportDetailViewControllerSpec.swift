//
//  AirportDetailViewControllerSpec.swift
//  AirportFinderTests
//
//  Created by mac on 10/4/19.
//

import Foundation
import Quick
import Nimble
import AFHandy

@testable import AirportFinder

class AirportDetailViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: AirportDetailViewController?
        
        describe("Verify AirportDetailViewController") {
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "AirportDetailViewController") as? AirportDetailViewController
                
                let airportService = MockAirportService()
                subject?.airport = airportService.getAirports().value?.first
                _ = subject?.view
            }
            
            context("When setup view") {
                
                it("Should display the airport details") {
                    expect(subject?.runwayLengthLabel.text).to(equal("Runway Length: \(subject?.airport?.runwayLength ?? "")"))
                    expect(subject?.cityLabel.text).to(equal("City: \(subject?.airport?.city ?? "")"))
                    expect(subject?.stateLabel.text).to(equal("State: \(subject?.airport?.state ?? "")"))
                    expect(subject?.countryLabel.text).to(equal("Country: \(subject?.airport?.country ?? "")"))
                    expect(subject?.timeZoneLabel.text).to(equal("Time Zone: \(subject?.airport?.timezone ?? "")"))
                    expect(subject?.directFlightLabel.text).to(equal("Direct Flights: \(subject?.airport?.directFlights ?? "")"))
                }
            }
        }
    }
}
