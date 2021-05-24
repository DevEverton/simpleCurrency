//
//  CountryListViewModel.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import Foundation
import SwiftUI

class CountryListViewModel: ObservableObject {
    
    @Published var baseCurrency = Currency(code: "USD")
    @Published var countries = [Country]()
    private var rates = [String:Double]()
    
    init() {
        getCurrencyList(base: baseCurrency.code)
    }
    
    func getFlag(country code: String) -> Flag? {
        return nil
    }
    
    func getCurrentValue(for country: Country) -> Double {
        return country.currency.currentValue ?? 0.0
    }
    
    func addCountry() {
        
    }
    
    
    //MARK: - Get request
    func getCurrencyList(base: String) {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(base)") else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(CurrencyReponse.self, from: data)
                    DispatchQueue.main.async {
                        self.rates = decodedData.rates
                    }

                } else {
                    print("No data \(String(describing: error))")
                    
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        .resume()

    }

}



