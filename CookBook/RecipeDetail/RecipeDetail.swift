//
//  RecipeDetail.swift
//  CookBook
//
//  Created by Владислав on 02.12.2022.
//

import UIKit

class RecipeDetail: UIViewController, UITableViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var recipeID = 653308
    var recipeData: RecipeData.RecipeDescription?
    var recipeNetworkManager = RecipeNetworkManager()
    
    let tableView: UITableView = .init()
    
    let titleDish: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageDish: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let difficultyLevelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let servesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins Regular", size: 16)
        return label
    }()
    
    let topHorizontalLine: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "horizontalLine")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let bottomHorizontalLine: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "horizontalLine")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Instruction:"
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins SemiBold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let recipeDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let downloadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupTableView()
        setupViews()
        setupDownloadingView()
        
        tableView.register(RecipeDetailCell.self, forCellReuseIdentifier: "RecipeDetailCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        recipeNetworkManager.searchRecipeById(by: recipeID) { [weak self] data in
            
            self!.recipeData = data
            self!.setRecipeData()
            
            DispatchQueue.main.async {
                self!.setupTableView()
                self!.tableView.reloadData()
            }
        }
    }
    
//    запрашиваем данные с сервера и обновляем интерфейс
    //MARK: - setRecipeData
    func setRecipeData() {
        
        if let recipeData = recipeData {
            DispatchQueue.main.async {
                
                if let dishImage = recipeData.image {
                    guard let apiURL = URL(string: dishImage) else { return }
                    URLSession.shared.dataTask(with: apiURL) { data, _, _ in
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                            self.imageDish.image = UIImage(data: data)
                        }
                    } .resume()
                }
                
                self.titleDish.text = recipeData.title
                guard let calories = recipeData.nutrition?.nutrients[0].amount else { return }
                self.caloriesLabel.text = String(format:"%2.f", calories) + " Calories"
                self.timeLabel.text = String(recipeData.readyInMinutes) + " min"
                self.servesLabel.text = "serves " + String(recipeData.servings)
                
//                текст инструкции приходит с сервера с лишними символами, ниже мы их заменяем на отступы. Если нет инструкции, то меняем instructionLabel
                if let recipeInstructions = recipeData.instructions {
                    self.recipeDescription.text = recipeInstructions.htmlToString
                } else {
                    self.instructionLabel.text = "No instruction 🥲"
                }
                
//                в зависимости от времени готовки, присваиваем степень тяжести рецепта
                switch recipeData.readyInMinutes {
                case ...20:
                    self.difficultyLevelLabel.text = "Easy"
                case 20...50:
                    self.difficultyLevelLabel.text = "Medium"
                case 51...:
                    self.difficultyLevelLabel.text = "Hard"
                default:
                    self.difficultyLevelLabel.text = ""
                }
                
//                когда все данные получены, то убираем вью с индикатором загрузки
                self.downloadingView.isHidden = true
            }
        }
    }
    
//    добавляем возможность скроллить экран
    //MARK: - setupScrollView
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
    
//    настройка размещения леблов и картинок на странице
    //MARK: - setupViews
    func setupViews(){
        
        let recipeDetailsStackView = UIStackView(arrangedSubviews: [caloriesLabel, timeLabel, difficultyLevelLabel, servesLabel])
        recipeDetailsStackView.axis = .horizontal
        recipeDetailsStackView.distribution = .equalSpacing
        recipeDetailsStackView.spacing = 10
        recipeDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleDish)
        contentView.addSubview(imageDish)
        contentView.addSubview(recipeDetailsStackView)
        contentView.addSubview(topHorizontalLine)
        contentView.addSubview(bottomHorizontalLine)
        contentView.addSubview(instructionLabel)
        contentView.addSubview(recipeDescription)
        
        NSLayoutConstraint.activate([
            titleDish.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleDish.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleDish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            imageDish.topAnchor.constraint(equalTo: titleDish.bottomAnchor, constant: 20),
            imageDish.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageDish.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageDish.heightAnchor.constraint(equalToConstant: 200),
            
            recipeDetailsStackView.topAnchor.constraint(equalTo: imageDish.bottomAnchor, constant: 20),
            recipeDetailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeDetailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            topHorizontalLine.topAnchor.constraint(equalTo: recipeDetailsStackView.bottomAnchor, constant: 20),
            topHorizontalLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topHorizontalLine.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            
            bottomHorizontalLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomHorizontalLine.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            
            instructionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionLabel.topAnchor.constraint(equalTo: bottomHorizontalLine.bottomAnchor, constant: 20),
            
            recipeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeDescription.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 12),
            recipeDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
//    настройка размещения таблицы
    //MARK: - setupTableView
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        if let data = recipeData {
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(((data.extendedIngredients.count ) * 40))).isActive = true
        }
        
    }
    
//    настройка вью с индикатором загрузки (отображается перед загрузкой данных с сервера)
    //MARK: - setupDownloadingView
    func setupDownloadingView() {
        downloadingView.backgroundColor  = .white
        downloadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(downloadingView)
        
        downloadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        downloadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        downloadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let downloadIndicator = UIActivityIndicatorView()
        downloadIndicator.style = UIActivityIndicatorView.Style.large
        downloadIndicator.color = UIColor(named: "MainColor")
        downloadIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        downloadIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
        downloadingView.addSubview(downloadIndicator)
        downloadIndicator.startAnimating()
    }
}

//MARK: - UITableViewDataSource
extension RecipeDetail: UITableViewDataSource {
    
//    указываем скролько строк будет в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = recipeData {
            return data.extendedIngredients.count
        } else {
            return 0
        }
    }
    
//    присваеваем строкам в таблице значения с севера
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDetailCell", for: indexPath) as? RecipeDetailCell else { fatalError() }
        if let data = recipeData {
            cell.ingredientsCountLabel.text = String(format:"%2.1f", data.extendedIngredients[indexPath.row].amount) + " " + (data.extendedIngredients[indexPath.row].unit ?? "")
            cell.ingredientsLabel.text = data.extendedIngredients[indexPath.row].name
        }
        return cell
    }
    
//    устанавливаем высоту ясейки в таблице
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
