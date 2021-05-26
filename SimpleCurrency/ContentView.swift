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
        NavigationView {
            List {
                ForEach(countryList.countries) { country in
                    Text("\(country.currency.code): \(country.currency.currentValue!)")
                }
            }
            .navigationBarTitle("Currencies")
            .onAppear {

            }

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
