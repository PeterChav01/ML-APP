//
//  CustomCell.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 22/11/22.
//

import UIKit

class CustomCell: UITableViewCell {
    // MARK: - CellComponents

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productCondition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupTitle()
        setupPrice()
        setupCondition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CellSetup
    
    private func setupImageView() {
        contentView.addSubview(productImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productImageView.heightAnchor.constraint(equalToConstant: 110),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            productImageView.widthAnchor.constraint(equalToConstant: 120),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTitle() {
        contentView.addSubview(productTitle)
        
        let constraints: [NSLayoutConstraint] = [
            productTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            productTitle.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5),
            productTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupPrice() {
        contentView.addSubview(productPrice)
        
        let constraints: [NSLayoutConstraint] = [
            productPrice.topAnchor.constraint(equalTo: productTitle.bottomAnchor,constant: 5),
            productPrice.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCondition() {
        contentView.addSubview(productCondition)
        
        let constraints: [NSLayoutConstraint] = [
            productCondition.topAnchor.constraint(equalTo: productPrice.bottomAnchor,constant: 5),
            productCondition.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5),
            productCondition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Configure Cell

    func configure(model: ProductCellModel) {
        productImageView.load(url: model.thumbnail)
        productTitle.text = model.title
        productPrice.text = model.price
        productCondition.text = model.condition
    }

}
