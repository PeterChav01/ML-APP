//
//  ViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 20/10/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate /* UISearchBarDelegate */ {
    // MARK: - UI Components
    /*
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    */
    
    
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
        return table
    }()
    
    
    private let table = UITableView()
   
    private var search: String? = ""
    
    // {}
    
    private let networkManager: ServiceProtocol
     
    // MARK: - Init
    init(networkMananager: ServiceProtocol) {
        self.networkManager = networkMananager
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var product = Product(results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        setupTableView()
        
    }
    
    private func setupNavBar() {
        title = "MercadoLibre"
    }
    
    private func setupSearchBar() {
        // 1. Agregar search bar a la vista del viewcontroller
        view.addSubview(searchBar)
        searchBar.placeholder = "Buscar Producto"
        
        // 2. Agregar constraints al search bar
        // x, y, width, height
        let constraints: [NSLayoutConstraint] = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // arriba
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor), // izquierda
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor) // derecha
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        
        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchBar.text!)
        search = searchBar.text
        return true
    }
    */
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(products[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = product.results[indexPath.row].title
        return cell
    }
}


//  MARK: - Get data from searchbar
    
extension ViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        networkManager.fetchData(for: "https://api.mercadolibre.com/sites/MLM/search?q=iphone") { result in
            switch result {
            case .success(let data):
                
                DispatchQueue.main.async {
                    self.product = data
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
//    func searchBarButton(searchBar: UISearchBar){
//        print("\(searchBar.text ?? "")")
//    }
}

