//
//  MealTypesVC.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

class MealTypesVC: UIViewController {
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Meal types"
        label.font = UIFont(name: "Poppins SemiBold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var recipeNetworkManager = RecipeNetworkManager()
    
    private var mealTypesCollectionView = MealTypesCollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.recipeNetworkManager.delegate = self
        self.recipeNetworkManager.getRecipes(.random)
        
        view.backgroundColor = .white
        
        view.addSubview(mainTitle)
        view.addSubview(logoImage)
        view.addSubview(mealTypesCollectionView)
        
        setAnchors()
        
    }
    
    func setAnchors() {
        
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 94).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 94).isActive = true
        
        
        mealTypesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mealTypesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mealTypesCollectionView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 5).isActive = true
        mealTypesCollectionView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
}

//MARK: - RecipeNetworkManagerDelegate
extension MealTypesVC: RecipeNetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        self.mealTypesCollectionView.cells = dataFromApi.recipes
        DispatchQueue.main.async {
            self.mealTypesCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

