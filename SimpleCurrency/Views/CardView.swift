//
//  CardView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 03/06/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    let country: Country
    var multiplier: Double

    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text(country.currency.code)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    AnimatedImage(url: Constants.flagLink(country.flagCode))
                        .resizable()
                        .frame(width: 32, height: 32)

                }
                .padding(.top, 5)
                HStack(alignment: .bottom) {
                    Spacer()
                    Text(String(country.currency.currentValue! * multiplier).toCurrencyFormat(code: country.currency.code))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }

            }
            .padding(.horizontal, 10)
            
        }
        .frame(width: 250)
        .frame(maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("purple1"), Color("purple2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 10, y: 10)

    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(country: Country(name: "United States", currency: Currency(code: "USD", currentValue: 0.0), flagCode: "US"), multiplier: 1.0)
        
    }
}

