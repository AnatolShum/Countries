//
//  GlobeView.swift
//  Countries
//
//  Created by Anatolii Shumov on 06.03.2024.
//

import SwiftUI
import MapKit
import SwiftData

struct GlobeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var countries: [Country]
    @Query private var locations: [Location]
    @ObservedObject private var viewModel = GlobeViewModel()
    @ObservedObject private var locationManager = LocationManager()
    @State private var searchQuery = ""
    @State private var position: MapCameraPosition
    
    init() {
        self.position = MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 52.375,
                    longitude: 4.9),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05)))
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(position: $position) {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            NavigationLink {
                                DetailView(country: location.country!)
                            } label: {
                                Image(systemName: "mappin")
                                    .frame(width: 15, height: 15)
                                    .tint(.pink)
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                
                searchBar
                    .padding(.horizontal, 15)
            }
            .onAppear() {
                if countries.isEmpty {
                    viewModel.fetchCountries(modelContext)
                }
                if locations.isEmpty {
                    viewModel.addLocations(from: countries, modelContext: modelContext)
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                guard let position = viewModel.updatePosition(
                    countries: countries,
                    searchQuery: newValue) else { return }
                self.position = position
            }
            .onChange(of: locationManager.location?.latitude) { _, _ in
                guard let position = viewModel.updatePosition(locationManager: locationManager) else { return }
                self.position = position
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .tint(.black.opacity(0.8))
            TextField("Search", text: $searchQuery)
                .font(Font.system(size: 18))
            
            if !searchQuery.isEmpty {
                Button(action: {
                    searchQuery = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .tint(.black.opacity(0.8))
                })
                .padding(.trailing, 5)
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.6))
        .clipShape(.capsule)
    }
}

#Preview {
    GlobeView()
}
