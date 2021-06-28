//
//  SettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 27/06/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings: UserSettingsStore
    
    private let decimalPlaces = [0, 1, 2, 3, 4]
    private let footerText = "If notifications are enabled you'll receive a daily notification with the current price of your choosen currency"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences"), footer: Text(footerText)) {

                    //MARK: - Layoput
                    HStack {
                        switch settings.userSettings.listLayout {
                        case .grid:
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("purple2"))
                        case .list:
                            Image(systemName: "list.bullet")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("purple2"))
                        }
                            
                        
                        Text("Layout")
                            .font(.system(size: 18, weight: .regular))
                        Spacer()

                        Picker(selection: $settings.userSettings.listLayout, label:
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 18, weight: .bold))
                                    .accentColor(.blue)
                        ) {
                            ForEach(UserSettings.ListLayout.allCases) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    //MARK: - Decimal Places
                    HStack {
                        Image(systemName: "00.circle")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.green)
                        Text("Decimal Places")
                            .font(.system(size: 18, weight: .regular))

                        Spacer()
                        Text("\(settings.userSettings.decimalPlaces)")
                            .foregroundColor(.gray)
                        Picker(selection: $settings.userSettings.decimalPlaces, label:
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 18, weight: .bold))
                                    .accentColor(.blue)
                        ) {
                            ForEach(decimalPlaces, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
   
                    }
                    
                    //MARK: - Notifications
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.yellow)

                        Toggle(isOn: $settings.userSettings.prefersNotifications, label: {
                            Text("Notifications")
                                .font(.system(size: 18, weight: .regular))
                        })
                    }
                    
                    
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: UserSettingsStore())
            
    }
}
