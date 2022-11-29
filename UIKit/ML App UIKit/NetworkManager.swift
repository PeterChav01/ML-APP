//
//  NetworkManager.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 03/11/22.
//

import Foundation

protocol ServiceProtocol {
    func fetchResultData(for search: String, completion: @escaping (Result<SearchResults, Error>) -> Void)
    func fetchProductDetail(for id: String, completion: @escaping (Result<ProductDetail, Error>) -> Void)
    
}

class NetworkManager: ServiceProtocol {
    
    func fetchProductDetail(for id: String, completion: @escaping (Result<ProductDetail, Error>) -> Void) {
        if let url = URL(string: "https://api.mercadolibre.com/items/\(id)") {
            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                if data != nil && error == nil {
                    do {
                        if let safeData = data {
                            let fetchingData = try JSONDecoder().decode(ProductDetail.self, from: safeData)
                            completion(.success(fetchingData))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
    
    func fetchResultData(for search: String, completion: @escaping (Result<SearchResults, Error>) -> Void) {
        if let url = URL(string: "https://api.mercadolibre.com/sites/MLM/search?q=\(search)") {
            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                if data != nil && error == nil {
                    do {
                        if let safeData = data {
                            let fetchingData = try JSONDecoder().decode(SearchResults.self, from: safeData)
                            completion(.success(fetchingData))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
    
    
}


