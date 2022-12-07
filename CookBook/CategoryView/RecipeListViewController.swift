//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    var showerDelegate: ShowPecipeDataDelegate?
    var recipeNetworkManager = RecipeNetworkManager()
    var dataApi = [RecipeData.RecipeDescription]()
    var tag = String()
    let tableView: UITableView = .init()
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Main course"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        tableView.register(RecipeTableCell.self, forCellReuseIdentifier: "RecipeTableCell")
        tableView.dataSource = self
        tableView.delegate = self
        recipeNetworkManager.delegate = self
        recipeNetworkManager.getRecipes(.categories, tag: tag)
        
        view.addSubview(mainTitle)
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
        ])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecipeDetail()
        vc.recipeID = dataApi[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


//MARK: - UITableViewDataSource - Load tableView data
extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataApi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableCell", for: indexPath) as? RecipeTableCell else { fatalError() }
        cell.selectionStyle = .none
        if dataApi.count > 0 {
            cell.titleLabel.text = dataApi[indexPath.row].title
            cell.ingredientsLabel.text = "\(dataApi[indexPath.row].extendedIngredients.count) Ingredients"
            cell.timeLabel.text = "\(dataApi[indexPath.row].readyInMinutes) min"
            cell.savedRecipesModel.setSaveButtonImage(button: cell.saveButton, recipeID: dataApi[indexPath.row].id)

            cell.data = dataApi[indexPath.row]
            cell.savedRecipesModel.setSaveButtonImage(button: cell.saveButton, recipeID: dataApi[indexPath.row].id)
            
            if let dishImage = dataApi[indexPath.row].image {
                guard let apiURL = URL(string: dishImage) else { return cell }
                URLSession.shared.dataTask(with: apiURL) { data, _, _ in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        cell.imageCell.image = UIImage(data: data)
                    }
                } .resume()
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate {

}

//MARK: - Private UI setup methods
extension RecipeListViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.text = tag

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - RecipeNetworkManagerDelegate
extension RecipeListViewController: RecipeNetworkManagerDelegate {
    func didFailWithError(error: Error) {
        print("error")
        let alertController = UIAlertController(title: "Error", message: "Network request fail with error: \(error). Try again?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try again", style: UIAlertAction.Style.default) {_ in
            self.recipeNetworkManager.getRecipes(.categories, tag: self.tag)
            }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func RecipesDidRecive(_ dataFromApi: RecipeData) { //  действия, когда данные получены (ассинхронно грузим в view)
        //dataFromApi.recipes.forEach { print($0.title)}
        DispatchQueue.main.async {
            self.dataApi = dataFromApi.results
            self.tableView.reloadData()
        }
    }
}

