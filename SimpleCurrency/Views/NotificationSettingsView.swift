//
//  NotificationSettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 05/07/21.
//

import SwiftUI

struct NotificationSettingsView: View {
    @StateObject var settings: UserSettingsStore
    @State private var date = Date()
    @State var calendar = Calendar.current
    

    var body: some View {
        Form {
            HStack {
                Toggle(isOn: $settings.userSettings.prefersNotifications, label: {
                    Text("Notifications Enabled")
                        .font(.system(size: 18, weight: .regular))
                })
            }
            if settings.userSettings.prefersNotifications {
                HStack {
                    Spacer()
                    DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .labelsHidden()

                }
            }
        }
        .animation(.easeInOut)
        .onChange(of: date) { _ in
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            settings.userSettings.notificationTime = NotificationTime(hour: hour, minutes: minutes)
        }

    }
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingsView(settings: UserSettingsStore())
    }
}
