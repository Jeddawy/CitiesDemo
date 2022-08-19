//
//  String+Extension.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        let double = formatter.number(from: self)?.doubleValue
        return double
    }
    
    func toInt() -> Int? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        let int = formatter.number(from: self)?.intValue
        return int
    }
}
