//
//  Main.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct Main: View {
    
    @StateObject var countryVM = CountryListViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
            Divider()
            BaseCurrencyView()
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(countryVM.countries) { country in
                        CardView(country: country)
                            
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
