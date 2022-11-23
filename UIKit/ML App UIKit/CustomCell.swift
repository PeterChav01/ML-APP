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
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CellSetup
    
    private func setupImageView() {
        addSubview(productImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            productImageView.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLabel() {
        addSubview(productLabel)
        
        let constraints: [NSLayoutConstraint] = [
            productLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            productLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    func configure(model: ProductCellModel) {
        productImageView.load(url: model.thumbnail)
        productLabel.text = model.title
    }

}
