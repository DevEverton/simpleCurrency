//
//  AddCountryViewModel.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 26/05/21.
//

import Foundation
import SwiftUI

class AddCountryViewModel: ObservableObject {
    
    @Published private var allCountries = [Country]()
}
