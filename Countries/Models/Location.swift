//
//  Location.swift
//  Countries
//
//  Created by Anatolii Shumov on 07.03.2024.
//

import Foundation
import CoreLocation
import SwiftData

@Model
class Location: Identifiable {
    let id: UUID = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var country: Country?
    
    init(name: String, coordinate: CLLocationCoordinate2D, country: Country? = nil) {
        self.name = name
        self.coordinate = coordinate
        self.country = country
    }
    
    
}

