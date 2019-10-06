//
//  AirportHelper.swift
//  AirportFinder
//
//  Created by mac on 10/4/19.
//

import Foundation
import PromiseKit

fileprivate extension String {
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
}

func jsonData(with file: String) -> Data {
    
    let bundle = Bundle(for: AirportHelper.self)
    
    guard let fileURL = bundle.path(forResource: file, ofType: "json")?.fileURL,
        let data = try? Data(contentsOf: fileURL, options: []) else {
            return Data()
    }
    
    return data
}

class AirportHelper {

    func getAirports() -> Promise<[Airport]> {
        
        let url = URL(string: ServiceUrl.getAirports)!
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode([Airport].self, from: $0.data)
        }
    }
}
