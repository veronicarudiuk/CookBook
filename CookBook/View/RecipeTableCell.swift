//
//  RecipeTableCell.swift
//  CookBook
//
//  Created by Марс Мазитов on 30.11.2022.
//
import UIKit

class RecipeTableCell: UITableViewCell {
    
    let data = [RecipeData.RecipeDescription]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 16)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    
    let textSeparatorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TextsSeparator")
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    
    let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "loading")
        imageView.sizeToFit()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [imageCell, titleLabel, ingredientsLabel, textSeparatorImage, timeLabel, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: -50),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 16),
            
            textSeparatorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textSeparatorImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            textSeparatorImage.leadingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor, constant: 7),
            textSeparatorImage.heightAnchor.constraint(equalToConstant: 8),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: textSeparatorImage.trailingAnchor, constant: 7),
            
            saveButton.topAnchor.constraint(equalTo: imageCell.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalToConstant: 32),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func keyPressed(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "SaveInactive") {
            sender.setImage(UIImage(named: "SaveActive"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "SaveInactive"), for: .normal)
        }
    }
}
