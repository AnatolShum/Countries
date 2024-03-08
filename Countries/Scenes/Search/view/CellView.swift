//
//  CellView.swift
//  Countries
//
//  Created by Anatolii Shumov on 08.03.2024.
//

import SwiftUI

struct CellView: View {
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: country.flags.url ?? "")) { image in
                image.resizable()
                    .frame(width: 60, height: 40)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.buttonBorder)
                    .padding(.leading, 4)
            } placeholder: {
                ProgressView()
            }
            
            Text(country.names.name)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "info.circle")
                .padding(.trailing, 15)
            
            
        }
        .frame(height: 48)
        .background(Color.gray.opacity(0.1))
        .clipShape(.buttonBorder)
    }
}

#Preview {
    CellView(country: Country(
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
