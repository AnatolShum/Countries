//
//  SearchView.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Country.names.name, order: .forward) private var countries: [Country]
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var searchQuery = ""
    private var filteredCountries: [Country] {
        if searchQuery.isEmpty {
            return countries
        }
        
        let filteredCountries = countries.compactMap { country in
            let countriesContainsQuery = country.names.name.range(
                of: searchQuery,
                options: .caseInsensitive) != nil
            
            return countriesContainsQuery ? country : nil
        }
        
        return filteredCountries
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.error != nil {
                    Text(viewModel.error!)
                } else {
                    List {
                        ForEach(filteredCountries) { country in
                            NavigationLink {
                                DetailView(country: country)
                            }  label: {
                                Text(country.names.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Countries")
        }
        .searchable(text: $searchQuery, prompt: "Country")
        .onAppear {
            if countries.isEmpty {
                viewModel.fetchCountries(modelContext)
            }
        }
        .overlay {
            if filteredCountries.isEmpty {
                ContentUnavailableView.search
            }
        }
    }
}

#Preview {
    SearchView()
}
