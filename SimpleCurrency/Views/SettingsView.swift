//
//  SettingsView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 27/06/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settings: UserSettingsStore

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.yellow)

                        Toggle(isOn: $settings.userSettings.prefersNotifications, label: {
                            Text("Notifications")
                                .font(.system(size: 18, weight: .regular))
                        })
                    }
                    HStack {
                        Image(systemName: "square.grid.2x2.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("purple2"))
                        Text("List Orientation")
                            .font(.system(size: 18, weight: .regular))
                        Spacer()
                        Menu {
                            Button(action: {
                                settings.userSettings.listOrientation = .horizontal
                            }, label: {
                                HStack {
                                    Text("Horizontal")
                                    Spacer()
                                    if settings.userSettings.listOrientation == .horizontal {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                }
                            })
                            Button(action: {
                                settings.userSettings.listOrientation = .vertical

                            }, label: {
                                HStack {
                                    Text("Vertical")
                                    Spacer()
                                    if settings.userSettings.listOrientation == .vertical {
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
