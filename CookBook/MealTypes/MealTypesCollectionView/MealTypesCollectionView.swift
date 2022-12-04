//
//  MealTypesCollectionView.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

final class MealTypesCollectionView: UICollectionView, UICollectionViewDelegate {
    

    var cells = mealsdata

    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        
        delegate = self
        dataSource = self
        
        register(MealTypeCell.self, forCellWithReuseIdentifier: MealTypeCell.reusedID)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MealTypesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealsdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: MealTypeCell.reusedID, for: indexPath) as! MealTypeCell
        
        cell.setup(with: mealsdata[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension MealTypesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width / 2) - 20, height: 100)
    }
}


extension MealTypesCollectionView {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(mealsdata[indexPath.row].title)
        //showerDelegate?.tagDidRecive(tag: mealsdata[indexPath.row].title)

    }
}

