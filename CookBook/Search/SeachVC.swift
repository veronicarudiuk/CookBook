//
//  SeachVC.swift
//  CookBook
//
//  Created by vasily on 04.12.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    var searchResults = [SearchData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    }
    
    var recipeNetworkManager = RecipeNetworkManager()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SearchCell.self, forCellReuseIdentifier: "cell")
        
        
        
        return tv
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search recipes..."
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .default
        
        search.searchBar.delegate = self
        
        return search
    }()
    
    let searchStub: UILabel = {
        let label = UILabel()
        label.text = "Let's find the tastiest recipe 🍕"
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Search recipes"
        
        
        setupElements()
    }
}



extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        if let recipeTitle = searchResults[safe: indexPath.row] {
            cell.titleLbl.text = recipeTitle.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipe = searchResults[safe: indexPath.row] {
            print(recipe.id)
            tagDidRecive(recipeID: recipe.id)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


//MARK: - Update TableView by searchResults
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchResults.isEmpty { searchStub.removeFromSuperview() }
        if searchText != "" {
            
            recipeNetworkManager.searchRecipe(by: searchText) { [weak self] data in
                self?.searchResults = data
            }
        }
    }
}


extension SearchVC {
    func setupElements() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.addSubview(searchStub)

        searchStub.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchStub.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}

extension SearchVC: ShowPecipeDataDelegate {
     func tagDidRecive(recipeID: Int) {
         let vc = RecipeDetail()
         vc.recipeID = recipeID
         present(vc, animated: true)
     }
  }
