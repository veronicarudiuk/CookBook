//
//  RecipeDataModel.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//

import Foundation

struct RecipeData: Decodable {
    let recipes: [RecipeDescription]
}

extension RecipeData {
    struct RecipeDescription: Decodable {
        let id: Int
        let title: String
        let image: String
        let instructions: String
        let readyInMinutes: Int
        let servings: Int
        let extendedIngredients: [Ingredients]
    }
    
    
    struct Ingredients: Decodable {
        let id: Int
        let name: String
        let amount: Double
        let unit: String?
    }
}
