//
//  Airport.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreLocation

public struct Airport: Codable, Hashable {
    
    public let code: String
    public let lat: String
    public let lon: String
    public let name: String
    public let city: String
    public let state: String
    public let country: String
    public let woeid: String
    public let timezone: String
    public let phone: String
    public let type: String
    public let email: String
    public let url: String
    public let runwayLength: String
    public let elev: String
    public let icao: String
    public let directFlights: String
    public let carriers: String
    public let location: CLLocation
    
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
    
    public init(from decoder: Decoder) throws {
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

public extension Airport {
    
    func hash(into hasher: inout Hasher) {
        city.hash(into: &hasher)
    }
    
    static func==(left: Airport, right: Airport) -> Bool {
        return left.city == right.city
    }
}
