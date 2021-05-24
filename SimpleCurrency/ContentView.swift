//
//  ContentView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var countryList = CountryListViewModel()
    
    var body: some View {
        Text("USD: \(countryList.rates["USD"] ?? 0.0)")
            .padding()
            .onAppear {
                countryList.getCurrencyList(base: "BRL")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
