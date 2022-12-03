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
        imageView.image = #imageLiteral(resourceName: "mealDefaultBackgroundOne")
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let mealTypeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mainImageView)
        contentView.addSubview(mealTypeName)
        contentView.clipsToBounds = true
        
        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        mealTypeName.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 8).isActive = true
        mealTypeName.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 5).isActive = true
        mealTypeName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mealTypeName.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
 class UIOutlinedLabel: UILabel {
 
 var outlineWidth: CGFloat = 5
 var outlineColor: UIColor = UIColor.black
 
 override func drawText(in rect: CGRect) {
 
 let strokeTextAttributes = [
 NSAttributedString.Key.strokeColor : outlineColor,
 NSAttributedString.Key.strokeWidth : -1 * outlineWidth,
 ] as [NSAttributedString.Key : Any]
 
 self.attributedText = NSAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
 super.drawText(in: rect)
 }
 }
 */

