//
//  Country.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import Foundation

struct Country: Identifiable {
    var id = UUID()
    var name: String
    var currency: Currency
//    var flag: Flag
}
