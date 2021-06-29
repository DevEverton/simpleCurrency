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

    @State var isSheetPresented = false
    @State var filteredList = [Country]()
        
    var body: some View {
        TabView {
            ConverterView(countryVM: countryListVM, settings: settings, isSheetPresented: $isSheetPresented, filteredList: filteredList)
                .tabItem {
                    Label("Converter", systemImage: "dollarsign.circle")
                        .background(Color.green)
                }
                .tag(Tab.converter)
            
            SettingsView(settings: settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")

                }
                .tag(Tab.settings)
        }
        .accentColor(Color("purple2"))

 
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
