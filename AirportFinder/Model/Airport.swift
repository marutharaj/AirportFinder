//
//  Airport.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import Foundation
import CoreLocation

struct Airport: Codable, Hashable {
    
    let code: String
    let lat: String
    let lon: String
    let name: String
    let city: String
    let state: String
    let country: String
    let woeid: String
    let timezone: String
    let phone: String
    let type: String
    let email: String
    let url: String
    let runwayLength: String
    let elev: String
    let icao: String
    let directFlights: String
    let carriers: String
    let location: CLLocation
    
    private enum CodingKeys: String, CodingKey {
        case code
        case lat
        case lon
        case name
        case city
        case state
        case country
        case woeid
        case timezone = "tz"
        case phone
        case type
        case email
        case url
        case runwayLength = "runway_length"
        case elev
        case icao
        case directFlights = "direct_flights"
        case carriers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        lat = try container.decode(String.self, forKey: .lat)
        lon = try container.decode(String.self, forKey: .lon)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        country = try container.decode(String.self, forKey: .country)
        woeid = try container.decode(String.self, forKey: .woeid)
        timezone = try container.decode(String.self, forKey: .timezone)
        phone = try container.decode(String.self, forKey: .phone)
        type = try container.decode(String.self, forKey: .type)
        email = try container.decode(String.self, forKey: .email)
        url = try container.decode(String.self, forKey: .url)
        runwayLength = try container.decodeIfPresent(String.self, forKey: .runwayLength) ?? ""
        elev = try container.decodeIfPresent(String.self, forKey: .elev) ?? ""
        icao = try container.decode(String.self, forKey: .icao)
        directFlights = try container.decode(String.self, forKey: .directFlights)
        carriers = try container.decode(String.self, forKey: .carriers)
        
        location = CLLocation(latitude: lat.toDouble() ?? 0.0, longitude: lon.toDouble() ?? 0.0)
    }
}

extension Airport {
    
    func hash(into hasher: inout Hasher) {
        city.hash(into: &hasher)
    }
    
    static func==(left: Airport, right: Airport) -> Bool {
        return left.city == right.city
    }
}
