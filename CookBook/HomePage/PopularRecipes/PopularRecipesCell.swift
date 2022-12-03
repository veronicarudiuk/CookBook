//
//  CollectionViewCell.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class PopularRecipesCell: UICollectionViewCell {
    
    static let reusedID = "PopularRecipesCell"
    private var savedRecipesModel = SavedRecipesModel()
    var recipeData = [RecipeData.RecipeDescription]()
    private var savedRecipesCollectionView = SavedRecipesCollectionView.shared
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "SaveInactive"), for: .normal)
        button.setImage(UIImage(named: "SaveActive"), for: .selected)
        button.addTarget(target, action: #selector(keyPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let recipeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categorieTitle: UILabel = {
        let label = UILabel()
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
        if sender.isSelected != true {
            savedRecipesModel.saveNewRecipe(recipeData)
            DispatchQueue.main.async {
                self.savedRecipesCollectionView.reloadData()
//                при добавлении большого количества рецептов коллекция автоматически скроллится до последнего
                let indexPath = IndexPath(row: self.savedRecipesModel.getSavedRecipesList().count - 1, section: 0)
                self.savedRecipesCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            }
        } else {
            savedRecipesModel.deleteRecipeFromSaved(recipeData)
            DispatchQueue.main.async {
                self.savedRecipesCollectionView.reloadData()
            }
        }
        sender.isSelected = !sender.isSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
