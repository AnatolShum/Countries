//
//  CountryName.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import SwiftData

@Model
class CountryName: Codable, Comparable, Equatable {
    var name: String
    var officialName: String

    init(name: String, officialName: String) {
        self.name = name
        self.officialName = officialName
    }
   
    enum CodingKeys: String, CodingKey {
        case name = "common"
        case officialName = "official"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let checkName = try container.decode(String.self, forKey: .name)
        let checkOfficialName = try container.decode(String.self, forKey: .officialName)
        if checkName.contains("Å") && checkOfficialName.contains("Å") {
            name = checkName.replacingOccurrences(of: "Å", with: "A")
            officialName = checkOfficialName.replacingOccurrences(of: "Å", with: "A")
        } else {
            name = checkName
            officialName = checkOfficialName
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(officialName, forKey: .officialName)
    }
    
    static func < (lhs: CountryName, rhs: CountryName) -> Bool {
        lhs.name < rhs.name
    }

    static func ==(lhs: CountryName, rhs: CountryName) -> Bool {
        return lhs.name == rhs.name
    }
}
