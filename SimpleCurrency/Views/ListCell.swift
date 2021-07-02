//
//  ListCell.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 01/07/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListCell: View {
    @StateObject var settings: UserSettingsStore
    let country: Country
    var multiplier: Double

    
    var body: some View {
        HStack {
            HStack {
                AnimatedImage(url: Constants.flagLink(country.flagCode))
                    .resizable()
                    .frame(width: 32, height: 32)
                Text("\(country.currencyName)")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .padding(.leading, 5)
                    .lineLimit(2)

                HStack(alignment: .bottom) {
                    Spacer()
                    Text(String(country.currencyData.currentValue! * multiplier).toCurrencyFormat(code: country.currencyData.code, decimalPlaces: settings.userSettings.decimalPlaces))
                        .font(.title3)
                        .foregroundColor(Color("title"))
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(settings: UserSettingsStore(), country: Country(currencyName: "US Dollar", currencyData: CurrencyData(code: "USD", currentValue: 0.0), flagCode: "US"), multiplier: 1.0)
            .previewLayout(.sizeThatFits)
            .padding(10)
    }
}
