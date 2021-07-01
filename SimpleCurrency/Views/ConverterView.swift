//
//  ConverterView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 21/06/21.
//

import SwiftUI

struct ConverterView: View {
    @StateObject var countryVM: CountryListViewModel
    @StateObject var settings: UserSettingsStore

    @Binding var isSheetPresented: Bool
    @State var filteredList = [Country]()
    
    
    var body: some View {
        VStack {
            HeaderView(countryListVM: countryVM)
                .padding(.top, 5)
            Divider()
            BaseCurrencyView(countryListVM: countryVM, settings: settings)
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                    
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("purple1"))
                })
            }
            .padding([.trailing, .top], 10)
            .padding(.bottom, 5)
            
            if countryVM.savedCountries.isEmpty {
                EmptyListView(isTapped: $isSheetPresented)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
            } else {
                
                switch settings.userSettings.listLayout {
                case .grid:
                    GridView(countryListVM: countryVM, settings: settings)

                case .list:
                    ListView(countryListVM: countryVM, settings: settings)
                }

                Spacer()
            }
            Spacer()

        }
        .sheet(isPresented: $isSheetPresented, content: {
            AddCurrencyView(countryListVM: countryVM, filteredList: filteredList)
        })
        .onTapGesture {
           dismissKeyboard()
        }
        .edgesIgnoringSafeArea(.bottom)

 
    }
    
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone 12 Pro Max", "iPhone 8"], id: \.self) { deviceName in
                ConverterView(countryVM: CountryListViewModel(), settings: UserSettingsStore(), isSheetPresented: .constant(false), filteredList: [])
                     .previewDevice(PreviewDevice(rawValue: deviceName))

            }
        }

    }
}

