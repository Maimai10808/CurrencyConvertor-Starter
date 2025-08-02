//
//  Rates.swift
//  CurrencyConvertor
//
//  Created by mac on 8/2/25.
//

import Foundation

struct Rates: Decodable {
    let rates: [String: Double]
}
