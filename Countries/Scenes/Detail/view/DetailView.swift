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
            VStack {
                Text(country.names.name)
                    .font(.title2)
                    .padding(.bottom, 10)
                
                AsyncImage(url: URL(string: country.flags.url ?? ""))
                    .padding(.bottom, 10)
                
                HStack(alignment: .center) {
                    Text("official name:")
                    Text(country.names.officialName)
                        .bold()
                }
                .padding(.bottom, 10)
                
                if let currency = viewModel.formattedCurrency() {
                    HStack(alignment: .center) {
                        Text("Currency:")
                        Text(currency)
                            .bold()
                    }
                    .padding(.bottom, 10)
                }
                
                HStack(alignment: .center) {
                    Text("Region:")
                    Text(country.region)
                        .bold()
                }
                .padding(.bottom, 10)
            }
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
