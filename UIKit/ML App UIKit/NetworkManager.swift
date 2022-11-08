//
//  NetworkManager.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 03/11/22.
//

import Foundation

protocol ServiceProtocol {
    func fetchData(for url: String, completion: @escaping (Result<Product, Error>) -> Void)
}

class NetworkManager: ServiceProtocol {
    func fetchData(for url: String, completion: @escaping (Result<Product, Error>) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                if data != nil && error == nil {
                    do {
                        let fetchingData = try JSONDecoder().decode(Product.self, from: data!)
                        completion(.success(fetchingData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
}


