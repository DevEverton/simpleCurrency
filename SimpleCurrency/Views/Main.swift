//
//  Main.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/06/21.
//

import SwiftUI

struct Main: View {
    
    @StateObject var countryVM = CountryListViewModel()
    @State var isSheetPresented = false
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible())
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
            
            if countryVM.savedCountries.isEmpty {
                EmptyListView(isTapped: $isSheetPresented)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .top){
                        ForEach(countryVM.savedCountries) { country in
                            CardView(country: country, multiplier: countryVM.multiplier)
                                .padding(.horizontal, 5)
                        }
                    }
                    .frame(maxHeight: 320)
                    .simultaneousGesture(DragGesture().onChanged({ _ in
                        dismissKeyboard()
                    }))
                }
                .frame(maxHeight: .infinity)
                Spacer()
            }
            Spacer()

        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $isSheetPresented, content: {
            AddCurrencyView(countryListVM: countryVM)
        })
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
           dismissKeyboard()
        }
 
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
