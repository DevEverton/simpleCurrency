//
//  UserSettings.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 26/06/21.
//

import Foundation
import Combine

struct UserSettings: Codable {
    
    var prefersNotifications: Bool
    var listLayout: ListLayout
    var decimalPlaces: Int
    
    static let `default` = UserSettings(prefersNotifications: false, listLayout: .grid, decimalPlaces: 2)

    enum ListLayout: String, Codable {
        case grid = "grid"
        case list = "list"
    }

}



