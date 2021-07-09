//
//  ConverterView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 21/06/21.
//

import SwiftUI
import SwiftfulLoadingIndicators


struct ConverterView: View {
    @StateObject var countryListVM: CountryListViewModel
    @StateObject var settings: UserSettingsStore

    @Binding var isSheetPresented: Bool
    @State var filteredList = [Country]()
    
    
    var body: some View {
        VStack {
            HeaderView(countryListVM: countryListVM)
                .padding(.top, 5)
            Divider()
            BaseCurrencyView(countryListVM: countryListVM, settings: settings)
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
            
            if countryListVM.savedCountries.isEmpty {
                EmptyListView(isTapped: $isSheetPresented)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
            } else {
                switch countryListVM.getRequest {
                case .loading:
                    VStack {
                        Spacer()
                        LoadingIndicator(animation: .threeBalls, color: Color("purple1"), size: .large, speed: .fast)
                        Spacer()
                    }
                    .padding(.bottom, 50)
                case .success, .failure:
                    switch settings.userSettings.listLayout {
                    case .grid:
                        GridView(countryListVM: countryListVM, settings: settings)
                            .transition(.slide)
                            .animation(.easeIn(duration: 0.2))
                        
                    case .list:
                        ListView(countryListVM: countryListVM, settings: settings)
                            .transition(.slide)
                            .animation(.easeIn(duration: 0.2))
                    }
                }
                

                Spacer()
            }
            Spacer()

        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {
            
        } , content: {
            AddCurrencyView(countryListVM: countryListVM, filteredList: filteredList)
        })

        .onTapGesture {
           dismissKeyboard()
        }
        
        .edgesIgnoringSafeArea(.bottom)

 
    }
    
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView(countryListVM: CountryListViewModel(), settings: UserSettingsStore(), isSheetPresented: .constant(false), filteredList: [])
//        Group {
//            ForEach(["iPhone 12 Pro Max", "iPhone 8"], id: \.self) { deviceName in
//                ConverterView(countryListVM: CountryListViewModel(), settings: UserSettingsStore(), isSheetPresented: .constant(false), filteredList: [])
//                     .previewDevice(PreviewDevice(rawValue: deviceName))
//
//            }
//        }

    }
}

