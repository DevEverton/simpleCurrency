//
//  UserSettingsStore.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 26/06/21.
//

import Foundation
import Combine

class UserSettingsStore: ObservableObject {
    @Published var userSettings = UserSettings.default {
        didSet {
            saveSettings()
        }

    }
    
    init() {
        loadSettings()
        
    }
    
    private func saveSettings() {
        let encoder = JSONEncoder()
        
        do {
            let encondedSettings = try encoder.encode(self.userSettings)
            UserDefaults.standard.set(encondedSettings, forKey: "settings")
            
        } catch let error {
            print("Error on saving Settings: \(error.localizedDescription)")
        }
        
    }
    
    private func loadSettings() {
        let decoder = JSONDecoder()
        
        do {
            if let savedSettings = UserDefaults.standard.object(forKey: "settings") as? Data {
                let decodedSettings = try decoder.decode(UserSettings.self, from: savedSettings)
                userSettings = decodedSettings
            }
        } catch let error {
            print("Error on loading Settings: \(error.localizedDescription)")
        }
    }
}
