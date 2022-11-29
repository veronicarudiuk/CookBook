//
//  RecipeListViewController.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    var recipeNetworkManager = RecipeNetworkManager()
    
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNetworkManager.delegate = self
        recipeNetworkManager.getRecipes(.random)
        view.backgroundColor = .systemBlue
        
        button.setTitle("Повторить запрос в Api", for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(requestToApi), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    @objc  func requestToApi(){
        recipeNetworkManager.getRecipes(.random)
    }
}

extension RecipeListViewController: RecipeNetworkManagerDelegate {
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
    func RecipesDidRecive(_ dataFromApi: RecipeData) { //  действия, когда данные получены (ассинхронно грузим в view)
        dataFromApi.recipes.forEach { print($0.title)}
    }
}
