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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.Title.titleFontSize, weight: .bold)
        label.numberOfLines = Constants.Title.numberLines
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.Labels.labelFontSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productCondition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.Labels.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Constants
    
    struct Constants {
        
        struct Title {
            static let titleFontSize: CGFloat = 18
            static let numberLines: Int = 3
        }
        
        struct Labels {
            static let labelFontSize: CGFloat = 18
        }
        
        struct ImageConstraints {
            static let top: CGFloat = 5
            static let bottom: CGFloat = -10
            static let height: CGFloat = 120
            static let width: CGFloat = 120
            static let leading: CGFloat = 5
            static let trailing: CGFloat = -10
        }
        
        struct TitleLabel {
            static let top: CGFloat = 5
            static let leading: CGFloat = 5
            static let trailing: CGFloat = -10
        }
        
        struct PriceLabel {
            static let top: CGFloat = 5
            static let leading: CGFloat = 5
            static let trailing: CGFloat = -10
        }
        
        struct ConditionLabel {
            static let top: CGFloat = 5
            static let leading: CGFloat = 5
            static let trailing: CGFloat = -10
        }
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
            productImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Constants.ImageConstraints.top),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Constants.ImageConstraints.bottom),
            productImageView.widthAnchor.constraint(equalToConstant: Constants.ImageConstraints.width),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.ImageConstraints.height),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ImageConstraints.leading),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTitle() {
        contentView.addSubview(productTitle)
        
        let constraints: [NSLayoutConstraint] = [
            productTitle.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: Constants.TitleLabel.top),
            productTitle.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.TitleLabel.leading),
            productTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.TitleLabel.trailing),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupPrice() {
        contentView.addSubview(productPrice)
        
        let constraints: [NSLayoutConstraint] = [
            productPrice.topAnchor.constraint(equalTo: productTitle.bottomAnchor,constant: Constants.PriceLabel.top),
            productPrice.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.PriceLabel.leading),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.PriceLabel.trailing)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCondition() {
        contentView.addSubview(productCondition)
        
        let constraints: [NSLayoutConstraint] = [
            productCondition.topAnchor.constraint(equalTo: productPrice.bottomAnchor,constant: Constants.ConditionLabel.top),
            productCondition.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: Constants.ConditionLabel.leading),
            productCondition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.ConditionLabel.trailing),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
