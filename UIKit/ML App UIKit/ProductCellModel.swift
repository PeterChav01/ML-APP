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
        price = "$ \(model.price) MXN"
        condition = "Condición: \(model.condition)"
        thumbnail = URL(string: model.thumbnail)
    }
    
//    private func formatNumber(number: Double) -> String {
//        let largeNumber = number
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        let formatedNumber = numberFormatter.string(from: NSNumber(value: largeNumber))!
//        return formatedNumber
//    }
}
