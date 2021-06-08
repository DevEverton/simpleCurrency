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
                        countryListVM.addBackToAllCountries(countryListVM.countries[indexSet.first!])
                        countryListVM.sortAllCountries()
                        countryListVM.countries.remove(atOffsets: indexSet)
                    }
                    .listStyle(GroupedListStyle())
                    .animation(.linear(duration: 0.3))
                }
                
                Section(header: Text("All Currencies")) {
                    ForEach(countryListVM.allCountries) { country in
                        CurrencyCell(country: country)
                            .onTapGesture {
                                countryListVM.addCountry(country: country)
                                countryListVM.remove(country: country)
                            }
                    }
                    .listStyle(GroupedListStyle())
                    .animation(.easeOut(duration: 0.5))

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
