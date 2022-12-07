//
//  HomePage.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

protocol ShowPecipeDataDelegate {
     func tagDidRecive(recipeID: Int)
  }

class HomePage: UIViewController {
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "Get amazing recipes for cooking"
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let popularRecipesTitle: UILabel = {
        let label = UILabel()
        label.text = "Trending now 🔥"
        label.font = UIFont(name: "Poppins SemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let savedRecipesTitle: UILabel = {
        let label = UILabel()
        label.text = "Saved recipes"
        label.font = UIFont(name: "Poppins SemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var popularRecipesCollecrionView = PopularRecipesCollectionView()
    
    private var savedRecipesCollectionView = SavedRecipesCollectionView.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularRecipesCollecrionView.showerDelegate = self
        savedRecipesCollectionView.showerDelegate = self
        
        view.backgroundColor = .white
        
        view.addSubview(mainTitle)
        view.addSubview(logoImage)
        view.addSubview(popularRecipesTitle)
        view.addSubview(popularRecipesCollecrionView)
        view.addSubview(savedRecipesTitle)
        view.addSubview(savedRecipesCollectionView)
        
        setAnchors()
    }
    
    func setAnchors() {
        
        mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: logoImage.leadingAnchor, constant: 8).isActive = true
        
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 94).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 94).isActive = true
        
        popularRecipesTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 22).isActive = true
        popularRecipesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        popularRecipesCollecrionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        popularRecipesCollecrionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popularRecipesCollecrionView.topAnchor.constraint(equalTo: popularRecipesTitle.bottomAnchor, constant: 16).isActive = true
        popularRecipesCollecrionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        savedRecipesTitle.topAnchor.constraint(equalTo: popularRecipesCollecrionView.bottomAnchor, constant: 36).isActive = true
        savedRecipesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        savedRecipesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        savedRecipesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        savedRecipesCollectionView.topAnchor.constraint(equalTo: savedRecipesTitle.bottomAnchor, constant: 16).isActive = true
        savedRecipesCollectionView.heightAnchor.constraint(equalToConstant: 190).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.popularRecipesCollecrionView.reloadData()
        }
    }
}

//MARK: - ShowPecipeDataDelegate
extension HomePage: ShowPecipeDataDelegate {
     func tagDidRecive(recipeID: Int) {
         let vc = RecipeDetail()
         vc.recipeID = recipeID
         self.navigationController?.pushViewController(vc, animated: true)
     }
  }

