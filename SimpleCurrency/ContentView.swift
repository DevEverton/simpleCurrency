//
//  ContentView.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var countryList = CountryListViewModel()

    
    var body: some View {
        NavigationView {
            List {
                ForEach(countryList.countries) { country in
                    HStack {
                        AsyncImage(url: Constants.flagLink(country.flagCode)) {
                            ProgressView()
                            
                        } image: { image in
                            Image(uiImage:  image)
                                .resizable()
                        }
                        .frame(width: 64, height: 64)
                        
                        Spacer()
                        
                        Text("\(country.currency.code): \(country.currency.currentValue!)")
                    }
                    .animation(.linear(duration: 0.5))

                }
            }
            .navigationBarTitle("Currencies")
            .onAppear {

            }

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
