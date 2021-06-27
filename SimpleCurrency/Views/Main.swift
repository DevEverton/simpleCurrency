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
    
    @StateObject var countryVM = CountryListViewModel()
    @State var isSheetPresented = false
    @State var filteredList = [Country]()
        
    var body: some View {
        TabView {
            ConverterView(countryVM: countryVM, isSheetPresented: $isSheetPresented, filteredList: filteredList)
                .tabItem {
                    Label("Converter", systemImage: "dollarsign.circle")
                        .background(Color.green)
                }
                .tag(Tab.converter)
            
            Text("Settings")
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
//        Main()
        ForEach(["iPhone 12 Pro", "iPhone 8"], id: \.self) { deviceName in
             Main()
                 .previewDevice(PreviewDevice(rawValue: deviceName))

         }
    }
}
