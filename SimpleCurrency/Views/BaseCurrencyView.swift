//
//  BaseCurrencyView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftfulLoadingIndicators

struct BaseCurrencyView: View {
    @StateObject var countryListVM: CountryListViewModel
    @StateObject var settings: UserSettingsStore
    
    @State var isSheetPresented = false
    @State var inputValue: Double? = 0.0
    
    
    let date = Date()
    
    var body: some View {
         VStack {
            HStack(spacing: 2) {
                Spacer()
                switch countryListVM.getRequest {
                case .loading:
                    LoadingIndicator(animation: .threeBalls, color: Color("purple1"), size: .small, speed: .fast)
                case .success:
                    Text("Updated:")
                    Text(date, style: .date)
                    Text(date, style: .time)
                case .failure:
                    Text("Connectivity failure")
                    
                }

            }
            .font(.system(size: 12, weight: .light, design: .rounded))
            .padding(.top, 5)
            .padding(.trailing, 10)

            
            Spacer()
            
            HStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Text(countryListVM.baseCountry.currencyData.code)
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
                CurrencyTextField("", value: $inputValue, alwaysShowFractions: false, numberOfDecimalPlaces: settings.userSettings.decimalPlaces, currencySymbol: "")
                    .font(.largeTitle)
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .onChange(of: inputValue ?? 0.0, perform: { value in
                        countryListVM.multiplier = value
                    })
                    .onTapGesture {
                        inputValue = 0.0
                        countryListVM.multiplier = 0.0
                    }
 
                
                Text(countryListVM.currencySymbol)
                    .font(.title)
                    .padding(.trailing, 10)
            }
            Spacer()

        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .sheet(isPresented: $isSheetPresented, content: {
            ChooseBaseCurrencyView(countryListVM: countryListVM)
        })

    }
    
    
    
}

struct BaseCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyView(countryListVM: CountryListViewModel(), settings: UserSettingsStore())
            

    }
}

