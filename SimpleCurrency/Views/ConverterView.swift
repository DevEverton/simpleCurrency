//
//  ConverterView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 21/06/21.
//

import SwiftUI

struct ConverterView: View {
    @StateObject var countryVM: CountryListViewModel
    @Binding var isSheetPresented: Bool
    @State var filteredList = [Country]()
    
    let rows = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        VStack {
            HeaderView(countryListVM: countryVM)
                .padding(.top, 10)
            Divider()
            BaseCurrencyView(countryListVM: countryVM)
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                    
                }, label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 20, weight: .black))
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
                                CardView(country: country, multiplier: countryVM.multiplier)
                                    .padding(5)
                            }
                        }
                        .frame(maxHeight: geometry.size.height - 30)
                        .simultaneousGesture(DragGesture().onChanged({ _ in
                            dismissKeyboard()
                        }))
                    }
                    .frame(maxHeight: geometry.size.height - 30)
                }

                Spacer()
            }
            Spacer()

        }
        .padding(.horizontal, 10)
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
        ConverterView(countryVM: CountryListViewModel(), isSheetPresented: .constant(false), filteredList: [])
    }
}
