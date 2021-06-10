//
//  Country.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import UIKit
import Foundation

struct Country: Identifiable, Codable{

    var id = UUID()
    var name: String
    var currency: Currency
    var flagCode: String
}
