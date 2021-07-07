//
//  Main.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct Main: View {
    
    enum Tab {
        case converter
        case settings
    }
    
    @StateObject var countryListVM = CountryListViewModel()
    @StateObject var settings = UserSettingsStore()
    var notification = LocalNotification()

    @State var isSheetPresented = false
    @State var filteredList = [Country]()
        
    var body: some View {
        TabView {
            ConverterView(countryListVM: countryListVM, settings: settings, isSheetPresented: $isSheetPresented, filteredList: filteredList)
                .tabItem {
                    Label("Converter", systemImage: "dollarsign.circle")
                }
                .tag(Tab.converter)
            
            SettingsView(settings: settings, listLayout: settings.userSettings.listLayout)
                .tabItem {
                    Label("Settings", systemImage: "gear")

                }
                .tag(Tab.settings)
        }
        .accentColor(Color("purple1"))
        .onChange(of: settings.userSettings.notificationTime) { _ in
            if settings.userSettings.prefersNotifications {
                notification.requestPermission()
                notification.removeNotification()

                notification.scheduleNotification(baseCurrency: countryListVM.baseCountry, savedCountries: countryListVM.savedCountries, time: settings.userSettings.notificationTime)
                
            } else {
                notification.removeNotification()
            }
        }
 
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
//        ForEach(["iPhone 12 Pro Max", "iPhone 12 mini"], id: \.self) { deviceName in
//             Main()
//                 .previewDevice(PreviewDevice(rawValue: deviceName))
//
//         }
    }
}
