//
//  CarouselCellCollectionViewCell.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 05/12/22.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    // MARK: - SubViews
    
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var priceLabel = UILabel()
    private var conditionLabel = UILabel()
    
    // MARK: - SubViews
    
    static let cellId = "CarouselCell"
    
    // MARK: - Properties
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }
}

private extension CarouselCell {
    func setupImageView(){
        addSubview(imageView)
        backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension CarouselCell {
    public func configure(image: UIImage?) {
        imageView.image = image
    }
}

