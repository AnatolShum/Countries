//
//  ContextManager.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import SwiftData
import SwiftUI

class ContextManager {
    func createModel(countries: [Country], modelContext: ModelContext) {
        countries.forEach { (value: Country) in
            modelContext.insert(value)
        }
    }
}
