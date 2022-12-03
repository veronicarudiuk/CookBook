//
//  SavedRecipesCell.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class SavedRecipesCell: UICollectionViewCell {
    
    static let reusedID = "SavedRecipesCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let recipeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins SemiBold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categorieTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "GrayTextColor")
        label.font = UIFont(name: "Poppins Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(recipeTitle)
        addSubview(categorieTitle)
        
        setAnchors()
    }
    
    func setAnchors() {
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        
        recipeTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        recipeTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        recipeTitle.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8).isActive = true
        
        categorieTitle.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 4).isActive = true
        categorieTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        categorieTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        categorieTitle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
