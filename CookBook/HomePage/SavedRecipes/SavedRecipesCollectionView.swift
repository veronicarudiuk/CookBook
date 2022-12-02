//
//  SavedRecipesCollectionView.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class SavedRecipesCollectionView: UICollectionView, UICollectionViewDelegate {
    
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SavedRecipesCell.reusedID, for: indexPath)
        
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
