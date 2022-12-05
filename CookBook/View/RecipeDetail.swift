//
//  RecipeDetail.swift
//  CookBook
//
//  Created by Владислав on 02.12.2022.
//

import UIKit

class RecipeDetail: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var recipeID = 0
    
    let tableView: UITableView = .init()
    
    let titleDish: UILabel = {
        let label = UILabel()
        label.text = "How to make Tasty Fish (point & Kill)"
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageDish: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image 13")
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "240 Calories"
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "40 min"
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let difficultyLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Hard"
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let servesLabel: UILabel = {
        let label = UILabel()
        label.text = "serves 1"
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let horizontalLine: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "horizontalLine")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let recipeDescription: UILabel = {
        let label = UILabel()
        label.text = "Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста "
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupTableView()
        setupViews()
        
        tableView.register(RecipeDetailCell.self, forCellReuseIdentifier: "RecipeDetailCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        
        let recipeDetailsStackView = UIStackView(arrangedSubviews: [caloriesLabel, timeLabel, difficultyLevelLabel, servesLabel])
        recipeDetailsStackView.axis = .horizontal
        recipeDetailsStackView.distribution = .equalSpacing
        recipeDetailsStackView.spacing = 10
        recipeDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleDish)
        contentView.addSubview(imageDish)
        contentView.addSubview(recipeDetailsStackView)
        contentView.addSubview(horizontalLine)
        contentView.addSubview(recipeDescription)
        
        NSLayoutConstraint.activate([
            titleDish.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleDish.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleDish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            imageDish.topAnchor.constraint(equalTo: titleDish.bottomAnchor, constant: 20),
            imageDish.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageDish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageDish.heightAnchor.constraint(equalToConstant: 200),
            
            recipeDetailsStackView.topAnchor.constraint(equalTo: imageDish.bottomAnchor, constant: 20),
            recipeDetailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeDetailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            horizontalLine.topAnchor.constraint(equalTo: recipeDetailsStackView.bottomAnchor, constant: 20),
            horizontalLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            horizontalLine.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            
            recipeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeDescription.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            recipeDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: (15 * 40)),
        ])
    }
}

extension RecipeDetail: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailCell", for: indexPath) as? RecipeDetailCell else { fatalError() }
        //        if dataApi.count > 0 {
        cell.ingredientsCountLabel.text = "104"
        cell.ingredientsLabel.text = "Muka"
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}

extension RecipeDetail: UITableViewDelegate {
    
}
