//
//  ProductDetailModel.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 12/12/22.
//

import Foundation

import Foundation

struct ProductDetailModel {
    
    let title: String
    let price: String
    let condition: String
    
    init(model: ProductResult) {
        title = model.title
        price = "$ \(model.price) MXN"
        condition = "Condición: \(model.condition)"
    }
}
