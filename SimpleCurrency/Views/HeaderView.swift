//
//  HeaderView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct HeaderView: View {
    @StateObject var countryListVM: CountryListViewModel
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("sCurrency")
                .font(.system(size: 35, weight: .semibold, design: .rounded))
                .foregroundColor(Color("title"))

            Spacer()
            
            Button(action: {
                countryListVM.getRequest = .loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    countryListVM.getCurrencyList(from: countryListVM.baseCountry.currency.code)

                }
                
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("purple1"))
            })
        }
        .padding(10)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(countryListVM: CountryListViewModel())
            .previewLayout(.sizeThatFits)

            
    }
}
