//
//  CountryName.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import SwiftData

@Model
class CountryName: Codable, Comparable {
    var name: String
    var officialName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "common"
        case officialName = "official"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        officialName = try container.decode(String.self, forKey: .officialName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(officialName, forKey: .officialName)
    }
    
    static func < (lhs: CountryName, rhs: CountryName) -> Bool {
        return lhs.name < rhs.name
    }
}
