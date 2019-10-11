//
//  MockAirportService.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import PromiseKit

fileprivate extension String {
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
}

private func jsonData(with file: String) -> Data {
    
    let bundle = Bundle(for: MockAirportService.self)
    
    guard let fileURL = bundle.path(forResource: file, ofType: "json")?.fileURL,
        let data = try? Data(contentsOf: fileURL, options: []) else {
            return Data()
    }
    
    return data
}

public class MockAirportService: AirportService {
    
    override public init() {}
    
    override public func getAirports() -> Promise<[Airport]> {
        do {
            let airports = try JSONDecoder().decode([Airport].self, from: jsonData(with: "airports"))
            return Promise.value(airports)
        } catch let parseError {
            return Promise.init(error: parseError)
        }
    }
}
