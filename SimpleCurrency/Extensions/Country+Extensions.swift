//
//  Country+Extensions.swift
//  SimpleCurrency
//
//  Created by Everton Carneiro on 25/05/21.
//

import Foundation


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
