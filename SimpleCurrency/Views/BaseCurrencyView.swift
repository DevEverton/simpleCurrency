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
    @State var inputValue: Double? = 0.0
    @State var isEditing = false
    
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
            HStack(alignment: .center) {
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        dismissKeyboard()
     
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 18, weight: .regular))
                            .accentColor(Color("purple2"))

                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .leading))
                    .animation(.default)
                    
                }
                
                CurrencyTextField("", value: $inputValue, alwaysShowFractions: false, numberOfDecimalPlaces: 2, currencySymbol: "$")
                    .font(.largeTitle)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .onChange(of: inputValue ?? 0.0, perform: { value in
                        countryListVM.multiplier = value
                    })
                    .onTapGesture {
                        self.isEditing = true

                    }
            }
            Spacer()

        }
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .sheet(isPresented: $isSheetPresented, content: {
            ChooseBaseCurrencyView(countryListVM: countryListVM)
        })

    }
    
    private func formatter(code: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(currencyCode: code)
        return formatter
    }
    
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView(countryListVM: CountryListViewModel())

    }
}

