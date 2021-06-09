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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Currencies")
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .padding(.leading, 10)
            SearchBar(searchText: $searchText)
                .padding(.vertical, 16)
                .padding(.horizontal, 10)
            List {
                ForEach(countryListVM.allCountries) { country in
                    HStack {
                        CurrencyCell(country: country)
                            .onTapGesture {
                                countryListVM.baseCountry = country
                                countryListVM.getCurrencyList(from: countryListVM.baseCountry.currency.code)
                            }
                        Spacer()
                        if countryListVM.baseCountry.name == country.name {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("purple1"))
                        }
                    }

                    
                }
                .animation(.easeOut(duration: 0.5))
            }

            
        }
        
    }
}

struct ChooseBaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBaseCurrencyView(countryListVM: CountryListViewModel())
    }
}
