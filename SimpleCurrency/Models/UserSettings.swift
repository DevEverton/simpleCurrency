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
    var goalDate = Date()

    static let `default` = UserSettings(prefersNotifications: true, listOrientation: .horizontal)

    enum ListOrientation {
        case horizontal, vertical
    }
}

