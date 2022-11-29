//
//  ViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 20/10/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   
    // MARK: - UI Components
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CustomViewCell.self, forCellReuseIdentifier: identifier)
        table.estimatedRowHeight = UITableView.automaticDimension
        return table
    }()
        
    private let identifier: String = "CustomViewCell"
    
    private let networkManager: ServiceProtocol
    private var product = Product(results: [])
    
    private var dispatchWorkItem: DispatchWorkItem?
    private let queue = DispatchQueue(label: "idk")
    
    enum Secwait: Double {
        case secs = 1.5
    }
         
    // MARK: - Init
    init(networkMananager: ServiceProtocol) {
        self.networkManager = networkMananager
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        setupTableView()
    }
    
// MARK: - Functions
    
    private func setupNavBar() {
        title = "MercadoLibre"
    }
    
    private func setupSearchBar() {

        view.addSubview(searchBar)
        searchBar.placeholder = "Buscar Producto"
        
        let constraints: [NSLayoutConstraint] = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func reloadData(product: Product) {
        DispatchQueue.main.async {
            self.product = product
            self.tableView.reloadData()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Shit Happened", message: "Some Shit Happened", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Well...Shit", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = product.results[indexPath.row].id
        let productDetailViewController = ProductDetailScreenViewController(productId: id)
        navigationController?.pushViewController(productDetailViewController, animated: true)
        
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CustomViewCell else {
            return UITableViewCell()
        }
        
        let model = product.results[indexPath.row]
        let productCellModel = ProductCellModel(model: model)
        cell.configure(model: productCellModel)
        
        return cell
    }
}

//  MARK: - Get data from searchbar

extension ViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dispatchWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            
            self?.networkManager.fetchData(for: "https://api.mercadolibre.com/sites/MLM/search?q=\(searchText)") { result in
                switch result {
                case .success(let data): self?.reloadData(product: data)
                case .failure:
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
                }
            }
        }
        
        dispatchWorkItem = workItem
        if let waitTime = dispatchWorkItem {
            queue.asyncAfter(deadline: .now() + Secwait.secs.rawValue, execute: waitTime)
        }
    }
}
