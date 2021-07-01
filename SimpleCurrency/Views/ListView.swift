//
//  ListView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/07/21.
//

import SwiftUI

struct ListView: View {
    @StateObject var countryListVM: CountryListViewModel
    @StateObject var settings: UserSettingsStore
    
    var body: some View {
            List {
                ForEach(countryListVM.savedCountries) { country in
                    ListCell(settings: settings, country: country, multiplier: countryListVM.multiplier)
                        .padding(5)
                }

            }
            .listStyle(InsetGroupedListStyle())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(countryListVM: CountryListViewModel(), settings: UserSettingsStore())
    }
}
