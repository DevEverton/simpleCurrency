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
    @State var editMode: EditMode = .inactive

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {

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
                        .onMove(perform: { indices, newOffset in
                            countryListVM.savedCountries.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .onReceive(countryListVM.$addCountryList, perform: { _ in
                            filteredList = countryListVM.addCountryList.sorted(by: { $0.currencyName < $1.currencyName })

                        })
                        .environment(\.editMode, $editMode)

                    }
                    
                    Section(header: Text("All Currencies")) {
                        ForEach(filteredList) { country in
                            CurrencyCell(country: country)
                                .onTapGesture {
                                    countryListVM.addCountry(country: country)
                                    countryListVM.remove(country: country)

                                }
                        }
                    }

                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Select")
                .navigationViewStyle(StackNavigationViewStyle())    
                .navigationBarItems(trailing: EditButton())
                .environment(\.editMode, $editMode)
            }
        }

    }

}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView(countryListVM: CountryListViewModel(), filteredList: [])
    }
}
