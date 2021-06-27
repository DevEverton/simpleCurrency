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
    var listOrientation: ListOrientation
    static let `default` = UserSettings(prefersNotifications: false, listOrientation: .horizontal)

    enum ListOrientation: String, Codable {
        case horizontal = "horizontal"
        case vertical = "vertical"
    }

}



