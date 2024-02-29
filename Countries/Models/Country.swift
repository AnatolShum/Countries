//
//  Countries.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import UIKit
import SwiftData

@Model
class Country: Codable, Comparable {
    var id: UUID {
        return UUID()
    }
    var name: CountryName
    var currencies: [String: [String: String]]?
    var capital: [String]?
    var region: String
    var subregion: String?
    var languages: [String: String]?
    var population: Int
    var car: Car
    var timezones: [String]
    var flags: Flag
    
    init(
        name: CountryName,
        currencies: [String: [String: String]]?,
        capital: [String]?,
        region: String,
        subregion: String?,
        languages: [String: String]?,
        population: Int,
        car: Car,
        timezones: [String],
        flags: Flag
    ) {
        self.name = name
        self.currencies = currencies
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.languages = languages
        self.population = population
        self.car = car
        self.timezones = timezones
        self.flags = flags
    }
    
    enum CodingKeys: CodingKey {
        case name
        case currencies
        case capital
        case region
        case subregion
        case languages
        case population
        case car
        case timezones
        case flags
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(CountryName.self, forKey: .name)
        currencies = try container.decodeIfPresent([String: [String: String]]?.self, forKey: .currencies) ?? nil
        capital = try container.decodeIfPresent([String]?.self, forKey: .capital) ?? nil
        region = try container.decode(String.self, forKey: .region)
        subregion = try container.decodeIfPresent(String?.self, forKey: .subregion) ?? nil
        languages = try container.decodeIfPresent([String: String]?.self, forKey: .languages) ?? nil
        population = try container.decode(Int.self, forKey: .population)
        car = try container.decode(Car.self, forKey: .car)
        timezones = try container.decode([String].self, forKey: .timezones)
        flags = try container.decode(Flag.self, forKey: .flags)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(capital, forKey: .capital)
        try container.encode(region, forKey: .region)
        try container.encodeIfPresent(subregion, forKey: .subregion)
        try container.encodeIfPresent(languages, forKey: .languages)
        try container.encode(population, forKey: .population)
        try container.encode(car, forKey: .car)
        try container.encode(timezones, forKey: .timezones)
        try container.encode(flags, forKey: .flags)
    }
    
    static func < (lhs: Country, rhs: Country) -> Bool {
        return lhs.name < rhs.name
    }
}
