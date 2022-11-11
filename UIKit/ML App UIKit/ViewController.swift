//
//  ViewController.swift
//  ML App UIKit
//
//  Created by Jose Chavez Aparicio on 20/10/22.
//

import UIKit

/// 1. ARC -  > Automatic Reference Counting
/// 2. Strong v Weak v Unowned
class ViewController: UIViewController, UITextFieldDelegate /* UISearchBarDelegate */ {
   
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
        return table
    }()
    
    private let networkManager: ServiceProtocol

    var product = Product(results: [])
    
    private var dispatchWorkItem: DispatchWorkItem?
    private let queue = DispatchQueue(label: "idk")
     
    // MARK: - Init
    init(networkMananager: ServiceProtocol) {
        self.networkManager = networkMananager
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    deinit {
        print("saliendo por la puerta")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearchBar()
        setupTableView()
        
        hideKeyboardWhenTappedAround()
        
    }
    
    
// MARK: - Functions
    
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



extension ViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dispatchWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            
            print("\(searchText)")
            self?.networkManager.fetchData(for: "https://api.mercadolibre.com/sites/MLM/search?q=\(searchText)") { result in
                switch result {
                case .success(let data): self?.reloadData(product: data)
                case .failure(let error):
                    print(error)
                    print("error")
                    
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
                }
            }
        }
        
        dispatchWorkItem = workItem
        if let waitTime = dispatchWorkItem {
            queue.asyncAfter(deadline: .now() + 2.5, execute: waitTime)
        }

    }
}

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

// {}

//class ViewController2: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        let button = UIButton(type: .system)
//        button.setTitle("Navegar a vista 2", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(navigateToViewController), for: .touchUpInside)
//        view.addSubview(button)
//        
//        let constraints = [button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                           button.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
//        
//        NSLayoutConstraint.activate(constraints)
//        
//    }
//    
//    @objc func navigateToViewController() {
//        show(
//            ViewController(
//                networkMananager: NetworkManager()
//            ),
//            sender: nil
//        )
//    }
//}
