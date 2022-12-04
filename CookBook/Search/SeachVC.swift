//
//  SeachVC.swift
//  CookBook
//
//  Created by vasily on 04.12.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    var searchResults = [RecipeData.RecipeDescription]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Search recipes"
        
        recipeNetworkManager.delegate = self
        
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
        
        cell.titleLbl.text = searchResults[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(searchResults[indexPath.row].id)
        print(searchResults[indexPath.row].title)
    }
}



extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
        recipeNetworkManager.getRecipes(.random)
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
    }
}


//MARK: - RecipeNetworkManagerDelegate
extension SearchVC: RecipeNetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        searchResults = dataFromApi.recipes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
