//
//  AddCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 04/06/21.
//

import SwiftUI

struct AddCurrencyView: View {
    
    @StateObject var countryListVM: CountryListViewModel
    
    @State var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.vertical, 16)
                .padding(.horizontal, 10)
            List {
                Section(header: Text("Selected Currencies")) {
                    ForEach(countryListVM.countries) { country in
                        CurrencyCell(country: country)
                    }
                    .onDelete { indexSet in
                        self.countryListVM.countries.remove(atOffsets: indexSet)

                    }
                    .listStyle(GroupedListStyle())

                }
                
                Section(header: Text("All Currencies")) {
                    ForEach(countryListVM.allCountries) { country in
                        CurrencyCell(country: country)
                    }
                    .onDelete { indexSet in
                        self.countryListVM.allCountries.remove(atOffsets: indexSet)

                    }
                    .listStyle(GroupedListStyle())
                }

            }
        }
    }
}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView(countryListVM: CountryListViewModel())
    }
}
