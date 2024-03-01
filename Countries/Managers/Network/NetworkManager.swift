//
//  NetworkManager.swift
//  Countries
//
//  Created by Anatolii Shumov on 29.02.2024.
//

import Foundation
import Combine

class NetworkManager<Model: Codable> {
    private let url = "https://restcountries.com/v3.1/all"
    
    enum NetworkErrors: Error {
        case invalidUrl
        case invalidDataTask
        case responseCodeIsNot200
        case badData
        case failedToDecodeData
    }
    
    func fetchCountries() -> Future<[Model], NetworkErrors> {
        return Future { promise in
            guard let url = URL(string: self.url) else {
                promise(.failure(.invalidUrl))
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    promise(.failure(.invalidDataTask))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    promise(.failure(.responseCodeIsNot200))
                    return
                }
                guard let data else {
                    promise(.failure(.badData))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode([Model].self, from: data)
                    promise(.success(model))
                } catch {
                    promise(.failure(.failedToDecodeData))
                }
            }.resume()
        }
    }
}
