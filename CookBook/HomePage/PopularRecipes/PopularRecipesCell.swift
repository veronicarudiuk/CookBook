//
//  CollectionViewCell.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class PopularRecipesCell: UICollectionViewCell {
    
    static let reusedID = "PopularRecipesCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "mealDefaultBackgroundOne")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let saveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "SaveInactive")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
//        label.text = "no category"
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
        addSubview(saveImageView)
        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        saveImageView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 8).isActive = true
        saveImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 240).isActive = true
        saveImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        saveImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        recipeTitle.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12).isActive = true
        
        
        categorieTitle.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 8).isActive = true
        categorieTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categorieTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categorieTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
