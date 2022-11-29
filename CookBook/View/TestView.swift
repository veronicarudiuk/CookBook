//
//  TestView.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//

import Foundation

class TestView: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        print(RecipeNetworkManager.stVar)
    }
    
}
