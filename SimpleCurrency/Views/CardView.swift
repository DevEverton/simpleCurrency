//
//  CardView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 03/06/21.
//

import SwiftUI

struct CardView: View {
    
    var country: Country
    
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text(country.currency.code)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    AsyncImage(url: Constants.flagLink(country.flagCode)) {
                        ProgressView()
                    } image: { image in
                        Image(uiImage:  image)
                            .resizable()

                    }
                    .frame(width: 32, height: 32)
                    .animation(.easeIn(duration: 0.5))
                }
                HStack(alignment: .bottom) {
                    Spacer()
                    Text(String(format: "%.2f", country.currency.currentValue!))
                        .font(.system(size: 48, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                }

            }
            .padding(.horizontal, 10)
            
        }
        .frame(width: 250, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("purple1"), Color("purple2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.8)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 10, y: 10)
        

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(country: Country(name: "United States", currency: Currency(code: "USD", currentValue: 0.0), flagCode: "US"))
        
    }
}
