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
            HStack {
                Spacer()
                Button(action: {
                    
                    countryVM.addCountry(country: Country(name: "Brazil", currency: Currency(code: "BRL", currentValue: 0.0), flagCode: "BRL"))
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("purple1"))
                })
            }
            .padding([.trailing, .vertical], 10)

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
