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
    @State var inputValue = 0.0
    
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
                TextField(
                     "0.00",
                      value: $inputValue,
                    formatter: formatter(code: countryListVM.baseCountry.currency.code),
                      onCommit: {
                        if inputValue.isNaN {
                            print("NAN")
                        }
                      })
                    .onChange(of: inputValue, perform: { value in
                        countryListVM.multiplier = value
                    })
                    .multilineTextAlignment(.trailing)
                    .font(.system(size: 55, weight: .regular, design: .rounded))

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

extension Locale: CaseIterable {
    public static let allCases: [Locale] = availableIdentifiers.map(Locale.init(identifier:))
}

public extension Locale {
    init?(currencyCode: String) {
        guard let locale = Self.allCases.first(where: { $0.currencyCode == currencyCode }) else { return nil }
        self = locale
     }
}
