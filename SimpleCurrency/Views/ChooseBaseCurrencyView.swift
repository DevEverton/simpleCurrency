//
//  ChooseBaseCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 09/06/21.
//

import SwiftUI

struct ChooseBaseCurrencyView: View {
    
    @StateObject var countryListVM: CountryListViewModel
    @State var searchText = ""
    @State var filteredList = [Country]()

    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
    //            Text("All Currencies")
    //                .font(.system(size: 30, weight: .semibold, design: .rounded))
    //                .padding(.leading, 10)
    //                .padding(.top)
                
                SearchBar(searchText: $searchText, listType: .allCountries, countryListVM: countryListVM, filteredList: $filteredList)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                List {
                    ForEach(filteredList) { country in
                        HStack {
                            CurrencyCell(country: country)
                                .onTapGesture {
                                    countryListVM.baseCountry = country
                                    countryListVM.getCurrencyList(from: countryListVM.baseCountry.currencyData.code)
                                    countryListVM.multiplier = 0.0
                                    presentationMode.wrappedValue.dismiss()
                                }
                            Spacer()
                            if countryListVM.baseCountry.currencyName == country.currencyName {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color.green)
                            }
                        }
                        
                    }
                    .animation(.easeOut(duration: 0.5))
                    .onReceive(countryListVM.$allCountries, perform: { _ in
                        filteredList = countryListVM.allCountries.sorted(by: { $0.currencyName < $1.currencyName })

                    })
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Choose")
     

            }
        }

        
        
    }
}

struct ChooseBaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBaseCurrencyView(countryListVM: CountryListViewModel())
    }
}
