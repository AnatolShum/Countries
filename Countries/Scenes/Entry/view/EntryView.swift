//
//  EntryView.swift
//  Countries
//
//  Created by Anatolii Shumov on 06.03.2024.
//

import SwiftUI
import UIKit

struct EntryView: View {
    var body: some View {
        tabView
    }
    
    @ViewBuilder var tabView: some View {
        TabView {
            GlobeView()
                .tabItem {
                    Label("Globe", systemImage: "globe")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .tint(.blue)
        
    }
}

#Preview {
    EntryView()
}
