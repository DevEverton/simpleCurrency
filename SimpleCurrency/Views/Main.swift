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
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("purple1"))
                })
            }
            .padding([.trailing, .vertical], 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .top){
                    ForEach(countryVM.savedCountries) { country in
                        CardView(country: country, multiplier: countryVM.multiplier)
                            .padding(.horizontal, 5)
                    }
                }
                
            }
            .frame(maxHeight: .infinity)
            Spacer()
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $isSheetPresented, content: {
            AddCurrencyView(countryListVM: countryVM)
        })
 
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
