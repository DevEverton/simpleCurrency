//
//  CurrencyData.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import Foundation

struct CurrencyData: Codable {
    var code: String
    var currentValue: Double?
}

struct CurrencyReponse: Codable {
    var rates: [String:Double]
}
