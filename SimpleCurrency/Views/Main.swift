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
                .padding(.horizontal, 10)
            BaseCurrencyView()
                .padding(.horizontal, 10)
            Divider()
            Spacer()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
