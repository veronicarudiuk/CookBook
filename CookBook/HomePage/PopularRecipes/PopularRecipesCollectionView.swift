//
//  PopularRecipesCollectionView.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class PopularRecipesCollectionView: UICollectionView, UICollectionViewDelegate {
    
    var cells = [RecipeData.RecipeDescription]()
    var recipeNetworkManager = RecipeNetworkManager()
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        self.recipeNetworkManager.delegate = self
        self.recipeNetworkManager.getRecipes(.random)
        
        register(PopularRecipesCell.self, forCellWithReuseIdentifier: PopularRecipesCell.reusedID)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDataSource
extension PopularRecipesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PopularRecipesCell.reusedID, for: indexPath) as! PopularRecipesCell
        
        cell.recipeTitle.text = cells[indexPath.row].title
        cell.recipeData = [cells[indexPath.row]]
//        print(cell.recipeData)
        
        if let dishesTypes = cells[indexPath.row].dishTypes {
            if dishesTypes != [] {
                let stringDishTypes = dishesTypes.joined(separator: ", ")
                cell.categorieTitle.text = stringDishTypes
            } else {
                cell.categorieTitle.text = "no category"
            }
        }
        
        if let dishImage = cells[indexPath.row].image {
            guard let apiURL = URL(string: dishImage) else { return cell }
            URLSession.shared.dataTask(with: apiURL) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell.mainImageView.image = UIImage(data: data)
                }
            } .resume()
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularRecipesCollectionView: UICollectionViewDelegateFlowLayout {
    //    устанавливаю размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 240)
    }
}

//MARK: - RecipeNetworkManagerDelegate
extension PopularRecipesCollectionView: RecipeNetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        self.cells = dataFromApi.recipes
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
