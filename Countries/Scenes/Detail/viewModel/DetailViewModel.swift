//
//  DetailViewModel.swift
//  Countries
//
//  Created by Anatolii Shumov on 04.03.2024.
//

import Foundation

class DetailViewModel: ObservableObject {
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    typealias OptionalFormattedCurrency = String?
    func formattedCurrency() -> OptionalFormattedCurrency {
        if !country.currencies.isEmpty {
            let formattedCurrencies = country.currencies.map { (currency: Currency) -> String in
                let code = currency.code
                let symbol = currency.symbol
                let name = currency.name
                
                return symbol != nil ?
                "\(code): (\(symbol ?? "")) \(name)" :
                "\(code): \(name)"
            }
            
            return formattedCurrencies.joined(separator: ", ")
        } else {
            return nil
        }
    }
}
