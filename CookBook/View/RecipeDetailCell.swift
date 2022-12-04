//
//  RecipeDetailCell.swift
//  CookBook
//
//  Created by Владислав on 04.12.2022.
//

import UIKit

class RecipeDetailCell: UITableViewCell {
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    let ingredientsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [ingredientsLabel, ingredientsCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            ingredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            ingredientsCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            ingredientsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            ingredientsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
