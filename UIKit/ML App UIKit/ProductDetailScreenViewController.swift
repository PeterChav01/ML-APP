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
        layout.itemSize = .init(width: Constants.CollectionView.width, height: Constants.CollectionView.height)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.Label.fontSize, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.Label.fontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = Constants.Label.numberOfLines
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.Label.fontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = Constants.Label.numberOfLines
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
    private let productId: String
    
    private var modelDetail: ProductDetail?

    private let networkManager: NetworkManager
    
    struct Constants {
    
        struct CollectionView {
            static let width = 300
            static let height = 300
        }
        
        struct Label {
            static let fontSize: CGFloat = 30
            static let numberOfLines = 3
        }
        
        struct Constraints {
            static let width: CGFloat = 300
            static let height: CGFloat = 300
            static let top: CGFloat = 30
        }
    }
    
    // MARK: - Init
    
    init(productId: String, networkManager: NetworkManager) {
        self.productId = productId
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        print(productId)
        fetchProductDetail()
        configureView()
        setupTitleLabel()
        setupPriceLabel()
        setupConditionLabel()
        
    }
    
    func fetchProductDetail() {
        networkManager.fetchProductDetail(for: productId) {
            switch $0 {
            case .success(let model):
                DispatchQueue.main.async { 
                    self.modelDetail = model
                    self.carouselCollectionView.reloadData()
                    self.titleLabel.text = self.modelDetail?.title
                    self.priceLabel.text = "$: \(self.modelDetail?.price ?? 0)"
                    self.conditionLabel.text = "Condición: \(self.modelDetail?.condition ?? "")"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureView() {
        view.addSubview(carouselCollectionView)
        
        let constraints: [NSLayoutConstraint] = [
            carouselCollectionView.widthAnchor.constraint(equalToConstant: Constants.Constraints.width),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: Constants.Constraints.height),
            carouselCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carouselCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Constraints.top)
        ]
        
        NSLayoutConstraint.activate(constraints)
        carouselCollectionView.reloadData()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: Constants.Constraints.top),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.width),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPriceLabel() {
        view.addSubview(priceLabel)
        
        let constraints: [NSLayoutConstraint] = [
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Constraints.top),
            priceLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.width),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConditionLabel() {
        view.addSubview(conditionLabel)
        
        let constraints: [NSLayoutConstraint] = [
            conditionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Constants.Constraints.top),
            conditionLabel.widthAnchor.constraint(equalToConstant: Constants.Constraints.width),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        return modelDetail?.pictures.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        let url = modelDetail?.pictures[indexPath.row].url
        cell.configure(url: url)
        return cell
    }
}
