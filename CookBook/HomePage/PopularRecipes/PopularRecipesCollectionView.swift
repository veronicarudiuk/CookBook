//
//  PopularRecipesCollectionView.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

final class PopularRecipesCollectionView: UICollectionView, UICollectionViewDelegate {
    
    var cells = [RecipeData.RecipeDescription]()
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(PopularRecipesCell.self, forCellWithReuseIdentifier: PopularRecipesCell.reusedID)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopularRecipesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PopularRecipesCell.reusedID, for: indexPath) as! PopularRecipesCell
        
        cell.recipeTitle.text = cells[indexPath.row].title
        
        if let dishesTypes = cells[indexPath.row].dishTypes {
            let stringDishTypes = dishesTypes.joined(separator: ", ")
            cell.categorieTitle.text = stringDishTypes
        } else {
            cell.categorieTitle.text = "no category"
        }
        
        
        return cell
    }
}

extension PopularRecipesCollectionView: UICollectionViewDelegateFlowLayout {
    //    устанавливаю размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 240)
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
