//
//  ProductDetailScreenViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 28/11/22.
//

import UIKit

class ProductDetailScreenViewController: UIViewController {
    // MARK: - UI Components

    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = productId
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelPrice: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Precio: $ \(productId)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelCondition: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Condicion: \(productId)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var productId: String = ""
    
    // MARK: - Init
    
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
        setupLabelTitle()
        setupLabelPrice()
        setupLabelCondition()
    }

    // MARK: - Functions
    
    private func setupLabelTitle() {
        view.addSubview(labelTitle)
        
        let constraints: [NSLayoutConstraint] = [
            labelTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLabelPrice() {
        view.addSubview(labelPrice)
        
        let constraints: [NSLayoutConstraint] = [
            labelPrice.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelPrice.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLabelCondition() {
        view.addSubview(labelCondition)
        
        let constraints: [NSLayoutConstraint] = [
            labelCondition.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 20),
            labelCondition.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
