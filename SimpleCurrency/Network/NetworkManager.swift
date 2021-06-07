//
//  NetworkManager.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 04/06/21.
//

import Foundation

class NetworkManager {
    
    init() {
        getCurrencyList(from: "USD")
    }
    
    var allCountries = [Country]()
    
    var rates = [String:Double]() {
        didSet {
            allCountries = Constants.countryCodes.map { Country(name: $0.key, currency: Currency(code: $0.value.0, currentValue: getCurrentValue(for: $0.value.0)), flagCode: $0.value.1) }
        }
    }

    func getCurrentValue(for code: String) -> Double {
        return rates[code] ?? 0.0
    }
    
    
    func getCurrencyList(from base: String) {
                
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(base)") else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(CurrencyReponse.self, from: data)
                    DispatchQueue.main.async { [self] in
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
