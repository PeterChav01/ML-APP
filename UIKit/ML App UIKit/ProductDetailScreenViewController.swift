//
//  ProductDetailScreenViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 28/11/22.
//

import UIKit

class ProductDetailScreenViewController: UIViewController {
    
    private var productId: String = ""
    
    init(productId: String) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        print(productId)
    }
    

    
}
