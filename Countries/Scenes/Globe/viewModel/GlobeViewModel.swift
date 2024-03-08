//
//  GlobeViewModel.swift
//  Countries
//
//  Created by Anatolii Shumov on 06.03.2024.
//

import Foundation
import SwiftData
import CoreLocation
import Combine
import _MapKit_SwiftUI

class GlobeViewModel: ObservableObject {
    private let networkManager = NetworkManager<Country>()
    private var cancellable: AnyCancellable?
    private var contextManager: ContextManager?
    @Published var error: String?
    
    func fetchCountries(_ modelContext: ModelContext) {
        cancellable = networkManager.fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case .invalidUrl:
                        self?.error = "Invalid URL"
                    case .invalidDataTask:
                        self?.error = "Invalid Data Task"
                    case .responseCodeIsNot200:
                        self?.error = "HTTP response code does not equal 200"
                    case .badData:
                        self?.error = "Data error"
                    case .failedToDecodeData:
                        self?.error = "Failed to decode data"
                    }
                }
            }, receiveValue: { [weak self] countries in
                self?.contextManager = ContextManager()
                self?.contextManager?.createModel(models: countries, modelContext: modelContext)
            })
    }
    
    func addLocations(from countries: [Country], modelContext: ModelContext) {
        let locations = countries.compactMap { (country: Country) -> Location? in
            if let coordinate = country.coordinate {
                let location = Location(
                    name: country.names.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude),
                    country: country)
                
                return location
            }
            
            return nil
        }
        
        self.contextManager = ContextManager()
        self.contextManager?.createModel(models: locations, modelContext: modelContext)
    }
    
    func updatePosition(countries: [Country], searchQuery: String) -> MapCameraPosition? {
        guard !searchQuery.isEmpty else { return nil }
        let filteredCountries = countries.compactMap { country in
            let contentsQuery = country.names.name.range(of: searchQuery, options: .caseInsensitive) != nil
            
            return contentsQuery ? country : nil
        }
        
        guard let country = filteredCountries.sorted(by: <).first else { return nil }
        guard let coordinate = country.coordinate else { return nil }
        
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 5,
                    longitudeDelta: 5)))
    }
    
    func updatePosition(locationManager: LocationManager) -> MapCameraPosition? {
        guard let latitude = locationManager.location?.latitude else { return nil }
        guard let longitude = locationManager.location?.longitude else { return nil }
        return MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude),
                span: MKCoordinateSpan(
                    latitudeDelta: 5,
                    longitudeDelta: 5)))
    }
}
