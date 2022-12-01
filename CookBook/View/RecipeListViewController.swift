//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//

import UIKit

class RecipeListViewController: UIViewController {
    var recipeNetworkManager = RecipeNetworkManager()
    let tableView: UITableView = .init()
    var dataApi = [RecipeData.RecipeDescription]()
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.register(RecipeTableCell.self, forCellReuseIdentifier: "RecipeTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        recipeNetworkManager.delegate = self
        recipeNetworkManager.getRecipes(.random)
        
        
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
        ])
    }
    
}

extension RecipeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableCell", for: indexPath) as? RecipeTableCell else { fatalError() }
        if dataApi.count > 0 {
            cell.titleLabel.text = dataApi[indexPath.row].title
            cell.infoLabel.text = "Information"
            
            guard let apiURL = URL(string: dataApi[indexPath.row].image) else { return cell }
            URLSession.shared.dataTask(with: apiURL) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell.imageCell.image = UIImage(data: data)                    }
            } .resume()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension RecipeListViewController: UITableViewDelegate {
    
}

extension RecipeListViewController {
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(mainTitle)

        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 66),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RecipeListViewController: RecipeNetworkManagerDelegate {
    func didFailWithError(error: Error) {
        recipeNetworkManager.getRecipes(.random)

        print("error")
    }
    
    func RecipesDidRecive(_ dataFromApi: RecipeData) { //  действия, когда данные получены (ассинхронно грузим в view)
        dataFromApi.recipes.forEach { print($0.title)}
        DispatchQueue.main.async {
            self.dataApi = dataFromApi.recipes
            
            self.tableView.reloadData()
            
        }
    }
}
