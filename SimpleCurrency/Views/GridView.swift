//
//  GridView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 29/06/21.
//

import SwiftUI

struct GridView: View {
    @StateObject var countryListVM: CountryListViewModel
    @StateObject var settings: UserSettingsStore
    
    let rows = [
        GridItem(.flexible(minimum: 120, maximum: 145)),
        GridItem(.flexible(minimum: 120, maximum: 145))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .top){
                    ForEach(countryListVM.savedCountries) { country in
                        CardView(settings: settings, country: country, multiplier: countryListVM.multiplier)
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
    }
}


struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(countryListVM: CountryListViewModel(), settings: UserSettingsStore())
            
    }
}
