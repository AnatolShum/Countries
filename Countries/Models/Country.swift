//
//  Countries.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import UIKit
import SwiftData

@Model
class Country: Codable, Equatable, Comparable {
    var names: CountryName
    var currencies: [Currency]
    var capital: [String]?
    var region: String
    var subregion: String?
    var languages: [String]
    var population: Int
    var car: Car
    var timezones: [String]
    var flags: Flag
    var coordinate: Coordinate?
    
    init(
        names: CountryName,
        currencies: [Currency],
        capital: [String]?,
        region: String,
        subregion: String?,
        languages: [String],
        population: Int,
        car: Car,
        timezones: [String],
        flags: Flag,
        coordinate: Coordinate?
    ) {
        self.names = names
        self.currencies = currencies
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.languages = languages
        self.population = population
        self.car = car
        self.timezones = timezones
        self.flags = flags
        self.coordinate = coordinate
    }
    
    enum CodingKeys: String, CodingKey {
        case names = "name"
        case currencies
        case capital
        case region
        case subregion
        case languages
        case population
        case car
        case timezones
        case flags
        case coordinate = "latlng"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        names = try container.decode(CountryName.self, forKey: .names)
        let currencyData = try container.decodeIfPresent([String: [String: String]].self, forKey: .currencies)
        if let currencyData {
            let currencies = currencyData.map { (key: String, value: [String : String]) -> Currency in
                let code = key
                let name = value.first { (key: String, value: String) -> Bool in
                    key == "name"
                }?.value ?? "N/A"
                let symbol = value.first { (key: String, value: String) -> Bool in
                    key == "symbol"
                }?.value
                return Currency(code: code, name: name, symbol: symbol)
            }
            
            self.currencies = currencies
        } else {
            currencies = []
        }
        capital = try container.decodeIfPresent([String]?.self, forKey: .capital) ?? nil
        region = try container.decode(String.self, forKey: .region)
        subregion = try container.decodeIfPresent(String?.self, forKey: .subregion) ?? nil
        let languageData = try container.decodeIfPresent([String: String].self, forKey: .languages) ?? [:]
        languages = Array(languageData.values)
        population = try container.decode(Int.self, forKey: .population)
        car = try container.decode(Car.self, forKey: .car)
        timezones = try container.decode([String].self, forKey: .timezones)
        flags = try container.decode(Flag.self, forKey: .flags)
        let coordinateData = try container.decodeIfPresent([Double].self, forKey: .coordinate)
        if let coordinateData, coordinateData.count == 2 {
            let latitude = coordinateData.first!
            let longitude = coordinateData.last!
            let coordinate = Coordinate(latitude: latitude, longitude: longitude)
            self.coordinate = coordinate
        } else {
            coordinate = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(names, forKey: .names)
        try container.encodeIfPresent(capital, forKey: .capital)
        try container.encode(region, forKey: .region)
        try container.encodeIfPresent(subregion, forKey: .subregion)
        try container.encode(languages, forKey: .languages)
        try container.encode(population, forKey: .population)
        try container.encode(car, forKey: .car)
        try container.encode(timezones, forKey: .timezones)
        try container.encode(flags, forKey: .flags)
    }
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.names.name < rhs.names.name
    }
}
