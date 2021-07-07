//
//  LocalNotification.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 02/07/21.
//

import Foundation
import SwiftUI
import UserNotifications

struct LocalNotification {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { sucess, error in
            if sucess {
                print("all set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(baseCurrency: Country, savedCountries: [Country], time: NotificationTime?) {
        let emptyListBodyMessage = "Currency list is empty. Open the app and add currencies"
        
        var bodyMessage: String {
            if savedCountries.count <= 5 {
                return savedCountries.map { String($0.currencyData.currentValue!).toCurrencyFormat(code: $0.currencyData.code, decimalPlaces: 2) + " | " } .reduce("", {$0 + $1})
            }
            return savedCountries.map { String($0.currencyData.currentValue!).toCurrencyFormat(code: $0.currencyData.code, decimalPlaces: 2) + " | " }[..<5] .reduce("", {$0 + $1})
        }
        

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Current price of \(String(baseCurrency.currencyData.currentValue!).toCurrencyFormat(code: baseCurrency.currencyData.code, decimalPlaces: 2)) \(baseCurrency.currencyData.code)"
        
        notificationContent.body = savedCountries.isEmpty ? emptyListBodyMessage : bodyMessage
                                                
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
                        
        var datComp = DateComponents()
        datComp.hour = time?.hour ?? 8
        datComp.minute = time?.minutes ?? 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "price", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error : Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}


