//
//  ContentView.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Country.names.name, order: .forward) var countries: [Country]
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.error != nil {
                Text(viewModel.error!)
            } else {
                List {
                    ForEach(countries) { country in
                        VStack(alignment: .leading) {
                            Text(country.names.name)
                        }
                    }
                }
            }
        }
        .navigationTitle("Countries")
        .onAppear {
            if countries.isEmpty {
                viewModel.fetchCountries(modelContext)
            }
        }
    }
}

#Preview {
    MainView()
}
