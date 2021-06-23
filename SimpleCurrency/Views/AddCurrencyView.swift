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
    @State var filteredList = [Country]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edit")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .padding(.leading, 10)
                .padding(.top)
            SearchBar(searchText: $searchText, listType: .addCountry, countryListVM: countryListVM, filteredList: $filteredList)
                .padding(.vertical, 16)
                .padding(.horizontal, 10)
            List {
                Section(header: Text("Selected Currencies")) {
                    ForEach(countryListVM.savedCountries) { country in
                        CurrencyCell(country: country)
                            
                    }
                    .onDelete { indexSet in
                        countryListVM.addBackToAllCountries(countryListVM.savedCountries[indexSet.first!])
                        countryListVM.sortAddCountryList()
                        countryListVM.savedCountries.remove(atOffsets: indexSet)
                    }
                    .animation(.linear(duration: 0.3))
                    .onReceive(countryListVM.$addCountryList, perform: { _ in
                        filteredList = countryListVM.addCountryList.sorted(by: { $0.name < $1.name })

                    })
                }
                
                Section(header: Text("All Currencies")) {
                    ForEach(filteredList) { country in
                        CurrencyCell(country: country)
                            .onTapGesture {
                                countryListVM.addCountry(country: country)
                                countryListVM.remove(country: country)
                            }
                    }
                    .animation(.easeOut(duration: 0.5))

                }

            }
            .listStyle(InsetGroupedListStyle())

        }

    }

}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView(countryListVM: CountryListViewModel(), filteredList: [])
    }
}
