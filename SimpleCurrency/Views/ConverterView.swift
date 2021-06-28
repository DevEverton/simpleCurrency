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
    
    let rows = [
        GridItem(.flexible(minimum: 120, maximum: 145)),
        GridItem(.flexible(minimum: 120, maximum: 145))
    ]
    
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
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, alignment: .top){
                            ForEach(countryVM.savedCountries) { country in
                                CardView(settings: settings, country: country, multiplier: countryVM.multiplier)
                                    .padding(5)
                            }
                        }
                        .frame(maxHeight: geometry.size.height - 30)
                        .simultaneousGesture(DragGesture().onChanged({ _ in
                            dismissKeyboard()
                        }))
                        .aspectRatio(contentMode: .fill)

                    }
                    .frame(maxHeight: geometry.size.height - 50)
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
        ForEach(["iPhone 12 Pro", "iPhone 8"], id: \.self) { deviceName in
            ConverterView(countryVM: CountryListViewModel(), settings: UserSettingsStore(), isSheetPresented: .constant(false), filteredList: [])
                 .previewDevice(PreviewDevice(rawValue: deviceName))

         }

    }
}
