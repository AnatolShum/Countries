//
//  Countries.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import UIKit
import SwiftData

@Model
class Country: Codable, Equatable {
    var names: CountryName
//    var currencies: [String: [String: String]]?
    var capital: [String]?
    var region: String
    var subregion: String?
//    var languages: [String: String]?
    var population: Int
    var car: Car
    var timezones: [String]
    var flags: Flag
    
    init(
        names: CountryName,
//        currencies: [String: [String: String]]?,
        capital: [String]?,
        region: String,
        subregion: String?,
//        languages: [String: String]?,
        population: Int,
        car: Car,
        timezones: [String],
        flags: Flag
    ) {
        self.names = names
//        self.currencies = currencies
        self.capital = capital
        self.region = region
        self.subregion = subregion
//        self.languages = languages
        self.population = population
        self.car = car
        self.timezones = timezones
        self.flags = flags
    }
    
    enum CodingKeys: String, CodingKey {
        case names = "name"
//        case currencies
        case capital
        case region
        case subregion
//        case languages
        case population
        case car
        case timezones
        case flags
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        names = try container.decode(CountryName.self, forKey: .names)
//        currencies = try container.decodeIfPresent([String: [String: String]].self, forKey: .currencies)
        capital = try container.decodeIfPresent([String]?.self, forKey: .capital) ?? nil
        region = try container.decode(String.self, forKey: .region)
        subregion = try container.decodeIfPresent(String?.self, forKey: .subregion) ?? nil
//        languages = try container.decodeIfPresent([String: String]?.self, forKey: .languages) ?? nil
        population = try container.decode(Int.self, forKey: .population)
        car = try container.decode(Car.self, forKey: .car)
        timezones = try container.decode([String].self, forKey: .timezones)
        flags = try container.decode(Flag.self, forKey: .flags)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(names, forKey: .names)
//        try container.encodeIfPresent(currencies, forKey: .currencies)
        try container.encodeIfPresent(capital, forKey: .capital)
        try container.encode(region, forKey: .region)
        try container.encodeIfPresent(subregion, forKey: .subregion)
//        try container.encodeIfPresent(languages, forKey: .languages)
        try container.encode(population, forKey: .population)
        try container.encode(car, forKey: .car)
        try container.encode(timezones, forKey: .timezones)
        try container.encode(flags, forKey: .flags)
    }
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
    
}
