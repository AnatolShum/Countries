//
//  Car.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import SwiftData

@Model
class Car: Codable {
    var side: String
    
    init(side: String) {
        self.side = side
    }
    
    enum CodingKeys: CodingKey {
        case side
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        side = try container.decode(String.self, forKey: .side)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(side, forKey: .side)
    }
}
