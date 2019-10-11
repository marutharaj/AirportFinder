//
//  AFHandyExtensions.swift
//  AFHandy
//
//  Created by mac on 10/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension String {
    
    internal func toDouble() -> Double? {
        
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    
    /// Remove duplicate cities
    internal func unique() -> [Iterator.Element] {
        
        var seen = Set<Iterator.Element>()
        
        return filter { seen.update(with: $0) == nil }
    }
}
