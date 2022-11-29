//
//  HomePage.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 29.11.22.
//

import UIKit

class HomePage: UIViewController {

    @IBOutlet private weak var popularRecipesTitle: UILabel!
    
    private var popularRecipesCollecrionView = PopularRecipesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(popularRecipesCollecrionView)
        popularRecipesCollecrionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        popularRecipesCollecrionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popularRecipesCollecrionView.topAnchor.constraint(equalTo: popularRecipesTitle.bottomAnchor, constant: 16).isActive = true
        popularRecipesCollecrionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    
    }


}
