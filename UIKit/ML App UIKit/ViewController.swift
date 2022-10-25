//
//  ViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 20/10/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Components
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
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
    
    private let products = [
        "iPhone",
        "Ipad",
        "Apple Watch",
        "iMac",
        "MacBook"
    ]
    // {}
    
    // MARK: - Init
    init() {
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
    
    private func setupNavBar() {
        title = "hola"
    }
    
    private func setupSearchBar() {
        // 1. Agregar search bar a la vista del viewcontroller
        view.addSubview(searchBar)
        
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
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(products[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
}
