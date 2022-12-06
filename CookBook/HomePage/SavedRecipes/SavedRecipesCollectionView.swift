//
//  SavedRecipesCollectionView.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class SavedRecipesCollectionView: UICollectionView, UICollectionViewDelegate {
    
    static let shared = SavedRecipesCollectionView()
    private var savedRecipesModel = SavedRecipesModel()
    var showerDelegate: ShowPecipeDataDelegate?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(SavedRecipesCell.self, forCellWithReuseIdentifier: SavedRecipesCell.reusedID)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDataSource
extension SavedRecipesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedRecipesModel.getSavedRecipesList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SavedRecipesCell.reusedID, for: indexPath) as! SavedRecipesCell
        
        let savedRecipesList = savedRecipesModel.getSavedRecipesList()
        
        if savedRecipesList.isEmpty { return cell } else {
            cell.recipeTitle.text  = savedRecipesList[indexPath.row].title
            
            if let dishesTypes = savedRecipesList[indexPath.row].dishTypes {
                if dishesTypes != [] {
                    let stringDishTypes = dishesTypes.joined(separator: ", ")
                    cell.categorieTitle.text = stringDishTypes
                } else {
                    cell.categorieTitle.text = "no category"
                }
            }
            
            if let dishImage = savedRecipesList[indexPath.row].image {
                guard let apiURL = URL(string: dishImage) else { return cell }
                URLSession.shared.dataTask(with: apiURL) { data, _, _ in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        cell.mainImageView.image = UIImage(data: data)
                    }
                } .resume()
            }
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SavedRecipesCollectionView: UICollectionViewDelegateFlowLayout {
    //    устанавливаю размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 124, height: 190)
    }
}

//MARK: - ShowPecipeDataDelegate
 extension SavedRecipesCollectionView {
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let savedRecipesList = savedRecipesModel.getSavedRecipesList()
          showerDelegate?.tagDidRecive(recipeInfo: savedRecipesList[indexPath.row])
      }
  }
