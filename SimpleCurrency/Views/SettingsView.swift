//
//  SettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 27/06/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings: UserSettingsStore
    
    var decimalPlaces = [0, 1, 2, 3, 4]
    

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    
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
                        Menu {
                            Button(action: {
                                settings.userSettings.listLayout = .grid
                            }, label: {
                                HStack {
                                    Text("Grid")
                                    Spacer()
                                    if settings.userSettings.listLayout == .grid {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                }
                            })
                            
                            Button(action: {
                                settings.userSettings.listLayout = .list

                            }, label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    if settings.userSettings.listLayout == .list {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                }
                            })
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.system(size: 18, weight: .bold))
                        }
                    }
                    //MARK: - Decimal Places
                    HStack {
                        Image(systemName: "00.circle")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.green)
                        Picker("Decimal Places", selection: $settings.userSettings.decimalPlaces) {
                            ForEach(decimalPlaces, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    .font(.system(size: 18, weight: .regular))
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
