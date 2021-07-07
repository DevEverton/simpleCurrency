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
    
    private var countriesJsonUrl = URL(fileURLWithPath: "SavedCountries", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    @Published var isSearching = false
    @Published var allCountries = [Country]()
    @Published var addCountryList = [Country]()
    @Published var getRequest: NetworkStatus
    @Published var multiplier: Double = 0.0
    @Published var currencySymbol = "$" 
    
    @Published var baseCountry = Country(currencyName: "US Dollar", currencyData: CurrencyData(code: "USD", currentValue: 0.0), flagCode: "US") {
        didSet {
            saveBaseCountry()
            getCurrencySymbol(from: baseCountry.currencyData.code)
        }
    }

    
    @Published var savedCountries = [Country]() {
        didSet {
            saveJSONCountryList()
            
        }
    }
    
    private var rates = [String:Double]()
    {
        didSet {
            updateAndSortData()
        }
    }
    
    init() {
        getRequest = .loading
        loadBaseCurrency()
        getCurrencyList(from: baseCountry.currencyData.code)
        loadJSONCountryList()
    }
    
    func updateAndSortData() {
        addCountryList = buildCountriesList()
        allCountries = buildCountriesList()
        sortAllCountries()
        removeSavedCountries()
        sortAddCountryList()
        updateValuesFor(savedCountries)
    }
    
    //MARK: - JSON local persistence
    
    private func loadJSONCountryList() {

        guard FileManager.default.fileExists(atPath: countriesJsonUrl.path) else { return }
        
        //        let filePath = FileManager.documentsDirectoryURL.path
        //        print(filePath)
        
        let decoder = JSONDecoder()
        
        do {
            let countriesData = try Data(contentsOf: countriesJsonUrl)
            savedCountries = try decoder.decode([Country].self, from: countriesData)

        } catch let error {
            print(error)
        }
    }
    
    private func saveJSONCountryList() {

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(savedCountries)
            try data.write(to: countriesJsonUrl, options: .atomicWrite)
        } catch let error {
            print(error)
            
        }
    }
    
    //MARK: - User Defaults local persistence
    
    private func saveBaseCountry() {
        let encoder = JSONEncoder()
        
        do {
            let encodedBaseCountry = try encoder.encode(baseCountry)
            UserDefaults.standard.set(encodedBaseCountry, forKey: "encodedBaseCountry")
            
        } catch let error {
            print(error)
        }
        
    }
    
    private func loadBaseCurrency() {
        let decoder = JSONDecoder()
        do {
            if let savedBaseCurrency = UserDefaults.standard.object(forKey: "encodedBaseCountry") as? Data {
                let decodedBaseCountry = try decoder.decode(Country.self, from: savedBaseCurrency)
                baseCountry = decodedBaseCountry
            }
        } catch let error {
            print(error)
        }
    }
    
    
    func getFlagCode(from name: String) -> String {
        Constants.countryCodes[name]!.1
    }
    
    func updateValuesFor(_ countries: [Country]) {
        self.savedCountries = countries.map{ Country(currencyName: $0.currencyName, currencyData: CurrencyData(code: $0.currencyData.code, currentValue: getCurrentValue(for: $0.currencyData.code)), flagCode: getFlagCode(from: $0.currencyName))  }
        self.baseCountry.currencyData.currentValue = getCurrentValue(for: baseCountry.currencyData.code)
    }
    
    func getCurrentValue(for code: String) -> Double {
        return rates[code] ?? 0.0
    }
    
    
    func addCountry(country: Country) {
        savedCountries.append(Country(currencyName: country.currencyName, currencyData: CurrencyData(code: country.currencyData.code, currentValue: getCurrentValue(for: country.currencyData.code)), flagCode: getFlagCode(from: country.currencyName)))
        
    }
    
    func addBackToAllCountries(_ country: Country) {
        addCountryList.append(Country(currencyName: country.currencyName, currencyData: CurrencyData(code: country.currencyData.code, currentValue: getCurrentValue(for: country.currencyData.code)), flagCode: getFlagCode(from: country.currencyName)))
    }
    
    func remove(country: Country) {
        if let index = getIndexOf(country: country) {
            addCountryList.remove(at: index)
        }
    }
    
    func getIndexOf(country: Country) -> Int? {
        
        for (index, element) in addCountryList.enumerated() {
            if element.id == country.id {
                return index
            }
        }
        return nil
    }
    
    func sortAddCountryList() {
        addCountryList = addCountryList.sorted(by: { $0.currencyName < $1.currencyName })
    }
    
    func sortAllCountries() {
        allCountries = allCountries.sorted(by: { $0.currencyName < $1.currencyName })
    }
    
    func removeSavedCountries() {
        if !savedCountries.isEmpty {
            for country in savedCountries {
                addCountryList = addCountryList.filter { $0.currencyName != country.currencyName }
            }
        }
    }
    
    func buildCountriesList() -> [Country] {
        Constants.countryCodes.map { Country(currencyName: $0.key, currencyData: CurrencyData(code: $0.value.0, currentValue: getCurrentValue(for: $0.value.0)), flagCode: $0.value.1) }
    }

    func search(_ name: String, listType: CountryListType) -> [Country] {
        
        isSearching = true
        
        if name.isEmpty {
            isSearching = false
            loadBaseCurrency()
            getCurrencyList(from: baseCountry.currencyData.code)
            loadJSONCountryList()
            switch listType {
            case .allCountries:
                return allCountries
            case .addCountry:
                return addCountryList
            }
        } else {
            switch listType {
            case .allCountries:
                return allCountries.filter { $0.currencyName.lc().contains(name.lc()) || $0.currencyData.code.lc().contains(name.lc()) }
                
            case .addCountry:
                return addCountryList.filter { $0.currencyName.lc().contains(name.lc()) || $0.currencyData.code.lc().contains(name.lc())  }
            }
        }
    }
    
    private func getCurrencySymbol(from code: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(currencyCode: code)
        currencySymbol = formatter.currencySymbol
    }
    

    //MARK: - Get request
    
    func getCurrencyList(from base: String) {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(base)") else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 15.0)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(CurrencyReponse.self, from: data)
                    DispatchQueue.main.async { [self] in
                        self.rates = decodedData.rates
                        getRequest = .success
                    }
                    
                } else {
                    print("No data \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.getRequest = .failure
                    }

                }
            } catch {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.getRequest = .failure
                }
            }
        }
        task.resume()
        
    }
        
}


enum CountryListType {
    case allCountries
    case addCountry
}

enum NetworkStatus: String {
    case loading = "Loading"
    case success = "Success!"
    case failure = "Error"
}
