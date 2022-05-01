//
//  SoketService.swift
//  AppNews
//
//  Created by Роман on 27.04.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func fetchSearch(with query: String, completion: @escaping
    (Result<[Article], NetworkError>) -> Void)
}

class StockService: StocksServiceProtocol {
    static let shared = StockService()
    private let network = NetworkCore.instance
    private let url = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=\(key)&q="
}

extension StockService {
    func fetchSearch(with query: String, completion: @escaping
                     (Result<[Article], NetworkError>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let url = StockService.shared.url + query
        network.fetchData(from: url, completion: completion)
    }
}
