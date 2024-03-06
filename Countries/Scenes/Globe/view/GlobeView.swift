//
//  GlobeView.swift
//  Countries
//
//  Created by Anatolii Shumov on 06.03.2024.
//

import SwiftUI
import MapKit

struct GlobeView: View {
    @ObservedObject private var viewModel = GlobeViewModel()
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationStack {
            Map()
                .mapStyle(.standard(elevation: .realistic))
            
                .toolbarBackground(.hidden, for: .navigationBar)
        }
        .searchable(text: $searchQuery, prompt: "Country")
    }
}

#Preview {
    GlobeView()
}
