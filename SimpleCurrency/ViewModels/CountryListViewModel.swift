//
//  CountryListViewModel.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import Foundation
import SwiftUI

class CountryListViewModel: ObservableObject {
    
    var countriesJsonUrl = URL(fileURLWithPath: "SavedCountries", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    @Published var baseCountry = Country(name: "Brazil", currency: Currency(code: "BRL"))
    @Published var countries = [Country]()
    private var rates = [String:Double]() {
        didSet {
            countries = Constants.countryCodes.map { Country(name: $0.key, currency: Currency(code: $0.value.0, currentValue: getCurrentValue(for: $0.value.0))) }
//
//            countries.append(Country(name: "United States", currency: Currency(code: "USD", currentValue: getCurrentValue(for: "USD"))))
            
            print(countries)
        }
    }
    
    init() {
        getCurrencyList(base: baseCountry.currency.code)
    }
    //MARK: - JSON local persistence
    
//    func loadCountriesJsonURL() {
//        guard FileManager.default.fileExists(atPath: countriesJsonUrl.path) else { return }
//        
////        let filePath = FileManager.documentsDirectoryURL.path
////        print(filePath)
//
//        let decoder = JSONDecoder()
//        
//        do {
//            let countriesData = try Data(contentsOf: countriesJsonUrl)
////            list = try decoder.decode([Tool].self, from: countriesData)
//        } catch let error {
//            print(error)
//        }
//    }
    
    func saveCountriesJsonURL() {
        
    }
    
    func getFlag(country code: String) -> Flag? {
        return nil
    }
    
    func getCurrentValue(for code: String) -> Double {
        return rates[code] ?? 0.0
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




