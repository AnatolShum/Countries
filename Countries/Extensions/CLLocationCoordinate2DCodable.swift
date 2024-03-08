//
//  CLLocationCoordinate2DCodable.swift
//  Countries
//
//  Created by Anatolii Shumov on 08.03.2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encodeIfPresent(longitude, forKey: .longitude)
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
}
