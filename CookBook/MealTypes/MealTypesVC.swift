//
//  MealTypesVC.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

protocol ShowPecipesDelegate {
    func tagDidRecive(tag: String)
}

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
    

    private var mealTypesCollectionView = MealTypesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTypesCollectionView.showerDelegate = self
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
        mealTypesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: - ShowPecipesDelegate
extension MealTypesVC: ShowPecipesDelegate {

    func tagDidRecive(tag: String) {
        let vc = RecipeListViewController()
        vc.tag = tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

