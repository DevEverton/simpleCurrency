//
//  BaseCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct BaseCurrencyView: View {
    @StateObject var countryListVM: CountryListViewModel
    
    @State var isSheetPresented = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    AsyncImage(url: Constants.flagLink(countryListVM.baseCountry.flagCode)) {
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
                    isSheetPresented.toggle()
                    
                }, label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("purple1"))
                })
     
            }
            .padding(10)
            HStack(alignment: .bottom) {
                Spacer()
                Text(String(format: "%.2f", countryListVM.baseCountry.currency.currentValue!))
                    .font(.system(size: 55, weight: .regular, design: .rounded))
                Text(countryListVM.baseCountry.currency.code)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .sheet(isPresented: $isSheetPresented, content: {
            //TODO: - Show all countries to choose the base country
            ChooseBaseCurrencyView(countryListVM: countryListVM)
        })

    }
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView(countryListVM: CountryListViewModel())
            .previewLayout(.sizeThatFits)

    }
}
