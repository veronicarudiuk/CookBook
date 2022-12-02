//
//  CollectionViewCell.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class PopularRecipesCell: UICollectionViewCell {
    
    static let reusedID = "PopularRecipesCell"
    var savedRecipesModel = SavedRecipesModel()
    var recipeData = [RecipeData.RecipeDescription]()
    private var savedRecipesCollectionView = SavedRecipesCollectionView.shared
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "mealDefaultBackgroundOne")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "SaveInactive"), for: .normal)
        button.addTarget(target, action: #selector(keyPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let recipeTitle: UILabel = {
        let label = UILabel()
        label.text = "How to sharwama at home"
        label.font = UIFont(name: "Poppins SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categorieTitle: UILabel = {
        let label = UILabel()
        label.text = "no category"
        label.textColor = UIColor(named: "GrayTextColor")
        label.font = UIFont(name: "Poppins Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(recipeTitle)
        addSubview(categorieTitle)
        addSubview(saveButton)
        
        setAnchors()
    }
    
    func setAnchors() {
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 8).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 240).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        recipeTitle.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12).isActive = true
        
        categorieTitle.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 8).isActive = true
        categorieTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categorieTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categorieTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func keyPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "SaveInactive") {
            sender.setImage(UIImage(named: "SaveActive"), for: .normal)
            savedRecipesModel.saveNewRecipe(recipeData)
            print(savedRecipesModel.getSavedRecipesList().count)
            DispatchQueue.main.async {
                self.savedRecipesCollectionView.reloadData()
            }
        } else {
            sender.setImage(UIImage(named: "SaveInactive"), for: .normal)
//            savedRecipesModel.deleteRecipeFromSaved(recipeData: recipeData)
//            print(savedRecipesModel.getSavedRecipesList())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
