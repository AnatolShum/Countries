//
//  Location.swift
//  Countries
//
//  Created by Anatolii Shumov on 07.03.2024.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id: UUID = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
