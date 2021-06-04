//
//  BaseCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct BaseCurrencyView: View {
    @StateObject var countryVM = CountryListViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    AsyncImage(url: Constants.flagLink(countryVM.baseCountry.flagCode)) {
                        ProgressView()
                        
                    } image: { image in
                        Image(uiImage:  image)
                            .resizable()
                    }
                    .frame(width: 32, height: 32)
                    .animation(.easeIn(duration: 0.5))
                }
                Button(action: {
                    //TODO: - Call modal view with all countries
                    
                    
                }, label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("purple1"))
                })
                
                
            }
            .padding(10)
            HStack(alignment: .bottom) {
                Spacer()
                Text(countryVM.baseCountry.currency.code)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(.bottom, 10)
                Text(String(format: "%.2f", countryVM.baseCountry.currency.currentValue!))
                    .font(.system(size: 55, weight: .regular, design: .rounded))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
    }
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView()
            .previewLayout(.sizeThatFits)

    }
}
