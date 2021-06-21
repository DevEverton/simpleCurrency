//
//  Main.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct Main: View {
    
    @StateObject var countryVM = CountryListViewModel()
    @State var isSheetPresented = false

    
    var body: some View {
        TabView {
            ConverterView(countryVM: countryVM, isSheetPresented: $isSheetPresented)
                .tabItem {
                    Label("Converter", systemImage: "dollarsign.circle")
                        .background(Color.green)
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")

                }

        }
        .accentColor(Color("purple2"))
 
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
