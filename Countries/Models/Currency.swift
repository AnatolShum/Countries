//
//  Currency.swift
//  Countries
//
//  Created by Anatolii Shumov on 04.03.2024.
//

import Foundation
import SwiftData

@Model
class Currency {
    var code: String
    var name: String
    var symbol: String?
    
    init(code: String, name: String, symbol: String?) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
