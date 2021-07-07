//
//  UserSettings.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 26/06/21.
//

import Foundation
import Combine

struct UserSettings: Codable {
    
    var date = Date()
    var prefersNotifications: Bool
    var notificationTime: NotificationTime? = nil
    var listLayout: ListLayout
    var decimalPlaces: Int
    
    static let `default` = UserSettings(prefersNotifications: false, listLayout: .grid, decimalPlaces: 2)

    enum ListLayout: String, Codable, CaseIterable, Identifiable {
        case grid = "Grid"
        case list = "List"
        
        var id: String { self.rawValue }
    }

}

struct NotificationTime: Codable, Equatable {
    var hour: Int
    var minutes: Int
}

