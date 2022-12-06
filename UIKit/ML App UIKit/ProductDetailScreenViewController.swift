//
//  ProductDetailScreenViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 28/11/22.
//

import UIKit

class ProductDetailScreenViewController: UIViewController {
    // MARK: - UI Components
    
    private lazy var carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 300, height: 300)
        layout.sectionInset = .zero
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        return collection
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = productId
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var carouselData: [CarouselData] = [
        CarouselData(image: UIImage(systemName: "iphone"), text: "iphone"),
        CarouselData(image: UIImage(systemName: "macmini"), text: "macmini"),
        CarouselData(image: UIImage(systemName: "applewatch"), text: "applewatch")
    ]
    
    private var productId: String = ""
    
    struct CarouselData  {
        let image: UIImage?
        let text: String
    }
    
    struct Constants {
    
    }
    
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
        view.backgroundColor = .white
        print(productId)
        configureView(with: carouselData)
        setupTitleLabel()
    }
    
    func configureView(with data: [CarouselData]) {
        carouselData = data
        view.addSubview(carouselCollectionView)
        
        let constraints: [NSLayoutConstraint] = [
            carouselCollectionView.widthAnchor.constraint(equalToConstant: 300),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 300),
            carouselCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //carouselCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carouselCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
        carouselCollectionView.reloadData()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UICollectionViewDataSource

extension ProductDetailScreenViewController: UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        let model = carouselData[indexPath.row]
        cell.configure(image: model.image)
        return cell
    }
}
