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
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "loading")
        imageView.sizeToFit()
        imageView.layer.cornerRadius = 25
        //imageView.contentMode = .scaleToFill

        return imageView
    }()
    
    let faviriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .systemPink
        //button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        //button.tag
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
        [imageCell, titleLabel, infoLabel].forEach { // убрал infoLabel
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        contentView.layer.cornerRadius = 25
//        contentView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0).cgColor
        contentView.layer.masksToBounds = true
        imageCell.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: imageCell.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: -50),
            
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
        
        ])
        
    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
