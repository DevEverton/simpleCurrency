//
//  CountryListViewModel.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 22/05/21.
//

import SwiftUI
import UIKit
import Foundation

class CountryListViewModel: ObservableObject {
    
    var countriesJsonUrl = URL(fileURLWithPath: "SavedCountries", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    
    @Published var baseCountry = Country(name: "United States", currency: Currency(code: "USD", currentValue: 0.0), flagCode: "US")
    @Published var allCountries = [Country]()
    @Published var countries = [Country]() {
        didSet {
            saveJSONCountryList()
        }
    }

    private var rates = [String:Double]() {
        didSet {
            allCountries = Constants.countryCodes.map { Country(name: $0.key, currency: Currency(code: $0.value.0, currentValue: getCurrentValue(for: $0.value.0)), flagCode: $0.value.1) }
            updateValuesFor(countries)

        }
    }
    
    init() {
        getCurrencyList(from: baseCountry.currency.code)
        loadJSONCountryList()
    }
    
    //MARK: - JSON local persistence
    
    private func loadJSONCountryList() {
        guard FileManager.default.fileExists(atPath: countriesJsonUrl.path) else { return }

//        let filePath = FileManager.documentsDirectoryURL.path
//        print(filePath)

        let decoder = JSONDecoder()

        do {
            let countriesData = try Data(contentsOf: countriesJsonUrl)
            countries = try decoder.decode([Country].self, from: countriesData)
        } catch let error {
            print(error)
        }
    }
    
    private func saveJSONCountryList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(countries)
            try data.write(to: countriesJsonUrl, options: .atomicWrite)
        } catch let error {
            print(error)
            
        }
    }

    func getFlagCode(from name: String) -> String {
        Constants.countryCodes[name]!.1
    }
    
    func updateValuesFor(_ countries: [Country]) {
        self.countries = countries.map{ Country(name: $0.name, currency: Currency(code: $0.currency.code, currentValue: getCurrentValue(for: $0.currency.code)), flagCode: getFlagCode(from: $0.name))  }
        self.baseCountry.currency.currentValue = getCurrentValue(for: baseCountry.currency.code)
    }
    
    func getCurrentValue(for code: String) -> Double {
        return rates[code] ?? 0.0
    }

    
    func addCountry(country: Country) {
        countries.append(Country(name: country.name, currency: Currency(code: country.currency.code, currentValue: getCurrentValue(for: country.currency.code)), flagCode: getFlagCode(from: country.name)))
        updateValuesFor(countries)

    }
    
    //MARK: - Get request
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
