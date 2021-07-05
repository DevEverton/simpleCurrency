//
//  NotificationSettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 05/07/21.
//

import SwiftUI

struct NotificationSettingsView: View {
    @StateObject var settings: UserSettingsStore
    @State var calendar = Calendar.current
    

    var body: some View {
        Form {
            HStack {
                Toggle(isOn: $settings.userSettings.prefersNotifications, label: {
                    Text("Enable Notifications").bold()

                })
            }
            if settings.userSettings.prefersNotifications {
                DatePicker(selection: $settings.userSettings.date, displayedComponents: .hourAndMinute) {
                    Text("Scheduled time")

                }
            }
            
        }
        .animation(.easeInOut)
        .onChange(of: settings.userSettings.date) { _ in
            let hour = calendar.component(.hour, from: settings.userSettings.date)
            let minutes = calendar.component(.minute, from: settings.userSettings.date)

            settings.userSettings.notificationTime = NotificationTime(hour: hour, minutes: minutes)
        }

    }
    
    
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingsView(settings: UserSettingsStore())
    }
}
