//
//  CustomCell.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 22/11/22.
//

import UIKit

class CustomViewCell: UITableViewCell {
    // MARK: - CellComponents

    private let productImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "bag.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelTitleSize.rawValue, weight: .bold)
        label.numberOfLines = LabelLines.labelLines.rawValue
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelTitleSize.rawValue, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productCondition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.labelTitleSize.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    enum Constants: CGFloat {
        case topView = 5
        case bottomView = -10
        case heightWidth = 120
        case leadingAnchor = 6
        case trailingView = -11
        case labelTitleSize = 18
    }
    
    enum LabelLines: Int {
        case labelLines = 3
    }
    
    // MARK: - Configure Cell

    func configure(model: ProductCellModel) {
        productTitle.text = model.title
        productPrice.text = model.price
        productCondition.text = model.condition
        productImageView.load(url: model.thumbnail)
        setupImageView()
        setupTitle()
        setupPrice()
        setupCondition()
    }
    
    // MARK: - CellSetup
    
    private func setupImageView() {
        contentView.addSubview(productImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Constants.topView.rawValue),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Constants.bottomView.rawValue),
            productImageView.widthAnchor.constraint(equalToConstant: Constants.heightWidth.rawValue),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.heightWidth.rawValue),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingAnchor.rawValue),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTitle() {
        contentView.addSubview(productTitle)
        
        let constraints: [NSLayoutConstraint] = [
            productTitle.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: Constants.topView.rawValue),
            productTitle.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.leadingAnchor.rawValue),
            productTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingView.rawValue),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupPrice() {
        contentView.addSubview(productPrice)
        
        let constraints: [NSLayoutConstraint] = [
            productPrice.topAnchor.constraint(equalTo: productTitle.bottomAnchor,constant: Constants.topView.rawValue),
            productPrice.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.leadingAnchor.rawValue),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingView.rawValue)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCondition() {
        contentView.addSubview(productCondition)
        
        let constraints: [NSLayoutConstraint] = [
            productCondition.topAnchor.constraint(equalTo: productPrice.bottomAnchor,constant: 5),
            productCondition.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5),
            productCondition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
