//
//  DetailView.swift
//  Countries
//
//  Created by Anatolii Shumov on 04.03.2024.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let country: Country
    @ObservedObject private var viewModel: DetailViewModel
    private let position: MapCameraPosition?
    
    init(country: Country) {
        self.country = country
        self._viewModel = ObservedObject(wrappedValue: DetailViewModel(country: country))
        guard let coordinate = country.coordinate else {
            self.position = nil
            return
        }
        self.position = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: 5,
                longitudeDelta: 5)))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AsyncImage(url: URL(string: country.flags.url ?? "")) { image in
                    image.resizable()
                        .clipped()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text(country.names.name)
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    TextView(
                        title: "Official name:",
                        description: country.names.officialName)
                    
                    if let capital = country.capital {
                        TextView(
                            title: "Capital:",
                            description: capital.joined(separator: ", "))
                    }
                    
                    if let currency = viewModel.formattedCurrency() {
                        TextView(
                            title: "Currency:",
                            description: currency,
                            alignment: .top)
                    }
                    
                    TextView(
                        title: "Region:",
                        description: country.subregion != nil ?
                        "\(country.region), \(country.subregion!)" : country.region,
                        alignment: country.subregion != nil ? .top : .center)
                    
                    if !country.languages.isEmpty {
                        TextView(
                            title: country.languages.count == 1 ? "Language:" : "Languages:",
                            description: country.languages.joined(separator: ", "))
                    }
                    
                    TextView(
                        title: "Population:",
                        description: country.population.formatted(.number))
                    
                    TextView(
                        title: "Left/Right-hand traffic:",
                        description: country.car.side)
                    
                    if !country.timezones.isEmpty {
                        TextView(
                            title: country.timezones.count == 1 ? "Time zone:" : "Time zones:",
                            description: country.timezones.joined(separator: ", "),
                            alignment: .top)
                    }
                    
                    if let flagInfo = country.flags.info {
                        TextView(
                            title: "Flag info:",
                            description: flagInfo,
                            alignment: .top)
                    }
                }
                .padding(.horizontal, 30)
                
                if let position {
                    Map(initialPosition: position, interactionModes: [.zoom])
                        .frame(height: 500)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .tint(.blue)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    DetailView(country: Country(
        names: CountryName(name: "Cyprus", officialName: "Republic of Cyprus"),
        currencies: [Currency(code: "EUR", name: "Euro", symbol: "€")],
        capital: ["Nicosia"],
        region: "Europe",
        subregion: "Southern Europe",
        languages: ["Greek", "Turkish"],
        population: 1207361,
        car: Car(side: "left"),
        timezones: ["UTC+02:00"],
        flags: Flag(
            url: "https://flagcdn.com/w320/cy.png",
            info: "The flag of Cyprus has a white field, at the center of which is a copper-colored silhouette of the Island of Cyprus above two green olive branches crossed at the stem."),
        coordinate: Coordinate(
            latitude: 35.0,
            longitude: 33.0)))
}
