//
//  MainViewModel.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import Combine
import SwiftData

class MainViewModel: ObservableObject {
    private let networkManager = NetworkManager<Country>()
    private var cancellable: AnyCancellable?
    @Published var error: String?
    
    func fetchCountries(_ modelContext: ModelContext) {
        cancellable = networkManager.fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case .invalidUrl:
                        self?.error = "Invalid URL"
                    case .invalidDataTask:
                        self?.error = "Invalid Data Task"
                    case .responseCodeIsNot200:
                        self?.error = "HTTP response code does not equal 200"
                    case .badData:
                        self?.error = "Data error"
                    case .failedToDecodeData:
                        self?.error = "Failed to decode data"
                    }
                }
            }, receiveValue: { countries in
                let contextManager = ContextManager()
                contextManager.createModel(countries: countries, modelContext: modelContext)
            })
    }
}
