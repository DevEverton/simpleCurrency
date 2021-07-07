//
//  SettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 27/06/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings: UserSettingsStore
    @State var listLayout: UserSettings.ListLayout

    
    private let decimalPlaces = [0, 1, 2, 3, 4]
    private let footerText = "If notifications are enabled you'll receive a daily notification with the current price of your choosen currency"
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences"), footer: Text(footerText)) {

                    //MARK: - Layout
                    HStack {
                        switch listLayout {
                        case .grid:
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("purple1"))
                        case .list:
                            Image(systemName: "list.bullet")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("purple1"))
                        }
                            
                        
                        Text("Layout")
                            .font(.system(size: 18, weight: .regular))
                        Spacer()

                        Picker(selection: $listLayout, label:
                                Image(systemName: "ellipsis.circle")
                                    .font(.system(size: 18, weight: .bold))
                                    .accentColor(.blue)
                        ) {
                            ForEach(UserSettings.ListLayout.allCases) {
                                Text($0.rawValue)
                                    .tag($0)
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
                    NavigationLink(
                        destination: NotificationSettingsView(settings: settings),
                        label: {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.yellow)

                                Text("Notifications")
                                    .font(.system(size: 18, weight: .regular))
                            }
                        })

                }
            }
            .navigationBarTitle("Settings")
            .onAppear {
                listLayout = settings.userSettings.listLayout
            }
            .onDisappear {
                settings.userSettings.listLayout = listLayout
            }


        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: UserSettingsStore(), listLayout: .grid)
            
    }
}
