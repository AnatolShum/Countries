//
//  DetailView.swift
//  Countries
//
//  Created by Anatolii Shumov on 04.03.2024.
//

import SwiftUI

struct DetailView: View {
    let country: Country
    @ObservedObject private var viewModel: DetailViewModel
    
    init(country: Country) {
        self.country = country
        self._viewModel = ObservedObject(wrappedValue: DetailViewModel(country: country))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .center, spacing: 10) {
                    Text(country.names.name)
                        .font(.title2)
                    
                    AsyncImage(url: URL(string: country.flags.url ?? ""))
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("Official name:")
                    Text(country.names.officialName)
                        .bold()
                }
                .padding(.bottom, 10)
                
                if let capital = country.capital {
                    HStack {
                        Text("Capital:")
                        Text(capital.joined(separator: ", "))
                            .bold()
                    }
                    .padding(.bottom, 10)
                }
                
                if let currency = viewModel.formattedCurrency() {
                    HStack(alignment: .top) {
                        Text("Currency:")
                        
                        VStack(alignment: .leading) {
                            Text(currency)
                                .bold()
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Region:")
                        Text(country.region)
                            .bold()
                    }
                    
                    if let subregion = country.subregion {
                        Text(subregion)
                            .bold()
                    }
                }
                .padding(.bottom, 10)
                
                if !country.languages.isEmpty {
                    HStack {
                        Text(country.languages.count == 1 ? "Language:" : "Languages:")
                        Text(country.languages.joined(separator: ", "))
                            .bold()
                    }
                    .padding(.bottom, 10)
                }
                
                HStack {
                    Text("Population:")
                    Text(country.population.formatted(.number))
                        .bold()
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("Left/Right-hand traffic:")
                    Text(country.car.side)
                        .bold()
                }
                .padding(.bottom, 10)
                
                if !country.timezones.isEmpty {
                    HStack(alignment: .top) {
                        Text(country.timezones.count == 1 ? "Time zone:" : "Time zones:")
                        VStack(alignment: .leading) {
                            Text(country.timezones.joined(separator: ", "))
                                .bold()
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                if let flagInfo = country.flags.info {
                    HStack(alignment: .top) {
                        Text("Flag info:")
                        VStack(alignment: .leading) {
                            Text(flagInfo)
                                .bold()
                        }
                    }
                }
                
            }
            .padding(.horizontal, 30)
        }
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
            info: "The flag of Cyprus has a white field, at the center of which is a copper-colored silhouette of the Island of Cyprus above two green olive branches crossed at the stem.")))
}
