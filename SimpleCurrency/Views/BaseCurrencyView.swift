//
//  BaseCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BaseCurrencyView: View {
    @StateObject var countryListVM: CountryListViewModel
    @State var isSheetPresented = false
    @State var inputValue = "0.00"
    
    let date = Date()
    
    var body: some View {
        VStack {
            
            HStack(spacing: 2) {
                Spacer()
                if countryListVM.getRequest != .success {
                    ProgressView()
                } else {
                    Text("Updated:")
                    Text(date, style: .date)
                    Text(date, style: .time)
                }
            }
            .font(.system(size: 12, weight: .light, design: .rounded))
            .padding(.top, 5)
            
            Spacer()
            
            HStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Text(countryListVM.baseCountry.currency.code)
                        .font(.system(size: 18, weight: .bold, design: .rounded))

                    AnimatedImage(url: Constants.flagLink(countryListVM.baseCountry.flagCode))
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                }

                Button(action: {
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
             
                TextField("", text: $inputValue)
                    .font(.system(size: 55, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.trailing)
                    .onChange(of: inputValue, perform: { value in
                        if inputValue.isEmpty {
                            inputValue = "0.0"
                        }
                        countryListVM.multiplier = Double(value) ?? 0.0
                    })
                    .keyboardType(.numberPad)

            }
            Spacer()

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

    }
}
