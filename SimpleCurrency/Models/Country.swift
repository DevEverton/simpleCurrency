//
//  Country.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import UIKit
import Foundation

struct Country: Identifiable, Codable, Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.currencyName == rhs.currencyName
    }

    var id = UUID()
    var currencyName: String
    var currencyData: CurrencyData
    var flagCode: String
}
