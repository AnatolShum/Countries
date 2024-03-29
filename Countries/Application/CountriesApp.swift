//
//  CountriesApp.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import SwiftUI
import SwiftData

@main
struct CountriesApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView()
        }
        .modelContainer(for: Country.self)
    }
}
