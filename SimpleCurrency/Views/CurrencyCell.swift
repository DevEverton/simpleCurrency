//
//  CurrencyCell.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 07/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CurrencyCell: View {
    
    let country: Country
    
    var body: some View {
        HStack {
            AnimatedImage(url: Constants.flagLink(country.flagCode))
                .resizable()
                .frame(width: 32, height: 32)
            Text("\(country.currencyName) (\(country.currencyData.code))")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .padding(.leading, 10)
        }
        .padding(.horizontal, 10)
    }
}

struct CurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCell(country: Country(currencyName: "United States", currencyData: CurrencyData(code: "USD", currentValue: 0.0), flagCode: "US"))
            .previewLayout(.sizeThatFits)
            .padding(10)
    }
}
