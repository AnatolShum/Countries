//
//  Coordinate.swift
//  Countries
//
//  Created by Anatolii Shumov on 05.03.2024.
//

import Foundation
import SwiftData

@Model
class Coordinate {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
