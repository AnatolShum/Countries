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
    func createModel<Model: PersistentModel>(models: [Model], modelContext: ModelContext) {
        models.forEach { (value: Model) in
            modelContext.insert(value)
        }
    }
}
