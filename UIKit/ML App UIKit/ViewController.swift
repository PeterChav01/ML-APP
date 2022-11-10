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
    
    private let networkManager: ServiceProtocol
    
//    private let debounce = Debounce(timeInterval: 2.5, queue: .global(qos: .userInitiated))
    
     
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
        
        hideKeyboardWhenTappedAround()
        
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
//        cell.textLabel?.text = product.results[indexPath.row].condition
//        cell.textLabel?.text = String(product.results[indexPath.row].price)
//        cell.textLabel?.text = product.results[indexPath.row].permalink
//        cell.textLabel?.text = product.results[indexPath.row].thumbnail
        return cell
    }
}


//  MARK: - Get data from searchbar
private var dispatchWorkItem: DispatchWorkItem?
private let queue = DispatchQueue(label: "idk")

extension ViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dispatchWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            print("\(searchText)")
            self.networkManager.fetchData(for: "https://api.mercadolibre.com/sites/MLM/search?q=\(searchText)") { result in
                switch result {
                case .success(let data):
                    
                    DispatchQueue.main.async {
                        self.product = data
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                    print("something failed")
                }
                
            }
        }
        dispatchWorkItem = workItem
        queue.asyncAfter(deadline: .now() + 2.5, execute: dispatchWorkItem!)
        
    }
}
// MARK: - Debounce
    
//class Debounce {
//    
//    private let timeInterval: TimeInterval
//    private let queue: DispatchQueue
//    private var dispatchWorkItem = DispatchWorkItem(block: {})
//    
//    init(timeInterval: TimeInterval, queue: DispatchQueue) {
//        self.timeInterval = timeInterval
//        self.queue = queue
//    }
//    
//    func dispatch(_ block: @escaping () -> Void) {
//        dispatchWorkItem.cancel()
//        let workItem = DispatchWorkItem {
//            block()
//        }
//        dispatchWorkItem = workItem
//        queue.asyncAfter(deadline: .now() + timeInterval, execute: dispatchWorkItem)
//    }
//}

// MARK: - Alert


// MARK: - Hide Keyboard

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
