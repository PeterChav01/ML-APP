//
//  ItemData.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 28/11/22.
//

import Foundation

struct ProductDetail: Decodable {
    let id: String
    let title: String
    let price: Double
    let condition: String
    let pictures: [PictureModel]
}

struct PictureModel: Decodable {
    let url: URL
    
    private enum CodingKeys: String, CodingKey {
        case url = "secure_url"
    }
}



