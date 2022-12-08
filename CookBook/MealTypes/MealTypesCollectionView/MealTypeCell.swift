//
//  MealTypeCell.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

final class MealTypeCell: UICollectionViewCell {
    
    static let reusedID = "MealTypeCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
        
        return imageView
    }()
    
    
    let mealTypeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins SemiBold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(with meal: MealTypesData) {
        mainImageView.image = meal.image
        mealTypeName.text = meal.title
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(mealTypeName)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        
        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        mealTypeName.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 65).isActive = true
        mealTypeName.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 5).isActive = true
        mealTypeName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mealTypeName.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


