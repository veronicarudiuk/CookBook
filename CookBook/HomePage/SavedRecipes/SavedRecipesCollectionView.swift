//
//  SavedRecipesCollectionView.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class SavedRecipesCollectionView: UICollectionView, UICollectionViewDelegate {
    
    static let shared = SavedRecipesCollectionView()
    
    var savedRecipesModel = SavedRecipesModel()
    
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
        //        обновить когда будет модель
        savedRecipesModel.getSavedRecipesList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SavedRecipesCell.reusedID, for: indexPath) as! SavedRecipesCell
        
        let savedRecipesList = savedRecipesModel.getSavedRecipesList()
        if savedRecipesList.isEmpty { return cell } else {
            cell.recipeTitle.text  = savedRecipesList[indexPath.row].title
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
