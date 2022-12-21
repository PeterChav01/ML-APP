//
//  Data.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 03/11/22.
//

import Foundation

struct SearchResults: Decodable  {
    let results: [ProductResult]
}

struct ProductResult: Decodable {
    let title: String
    let price: Double
    let condition: String
    let thumbnail: String
    let id: String
}


