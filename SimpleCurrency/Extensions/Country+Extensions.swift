//
//  Country+Extensions.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 25/05/21.
//

import Foundation
import SwiftUI


public extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

public extension String {
    func lc() -> String {
        self.lowercased()
    }
}

extension Locale: CaseIterable {
    public static let allCases: [Locale] = availableIdentifiers.map(Locale.init(identifier:))
}

public extension Locale {
    init?(currencyCode: String) {
        guard let locale = Self.allCases.first(where: { $0.currencyCode == currencyCode }) else { return nil }
        self = locale
     }
}

extension String {
    func toCurrencyFormat(code: String) -> String {
        if let doubleValue = Double(self){
           let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(currencyCode: code)
           return formatter.string(from: NSNumber(value: doubleValue)) ?? ""
      }
    return ""
  }
}


#if canImport(UIKit)
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
