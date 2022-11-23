//
//  ProductCellModel.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 22/11/22.
//

import Foundation



struct ProductCellModel {
    
    let title: String
    let price: String
    let condition: String
    let thumbnail: URL?
    //let permalink: String
    
    init(model: ProductDetail) {
        title = model.title
        price = String(model.price)
        condition = model.condition
        thumbnail = URL(string: model.thumbnail)
    }
    
    
    
}
