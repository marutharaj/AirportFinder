//
//  AirportService.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import PromiseKit

public class AirportService {
    
    public func getAirports() -> Promise<[Airport]> {
        
        let url = URL(string: ServiceUrl.getAirports)!
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode([Airport].self, from: $0.data)
        }
    }
}
