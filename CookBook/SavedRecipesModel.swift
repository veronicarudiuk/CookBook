//
//  Constants.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 2.12.22.
//

import Foundation
import UIKit

struct SavedRecipesModel {
    
    static var savedRecipes = [RecipeData.RecipeDescription]()
    
    mutating func saveNewRecipe(_ recipeData: RecipeData.RecipeDescription) {
        if SavedRecipesModel.savedRecipes.isEmpty {
            SavedRecipesModel.savedRecipes = [recipeData]
        } else if SavedRecipesModel.savedRecipes.contains(where: {$0.id == recipeData.id}) {
            return
        } else {
            SavedRecipesModel.savedRecipes.append(recipeData)
        }
    }

    mutating func deleteRecipeFromSaved(_ recipeData: RecipeData.RecipeDescription) {
        let recipeID = recipeData.id
        SavedRecipesModel.savedRecipes.removeAll(where: {$0.id == recipeID})
    }
    
    func getSavedRecipesList() -> [RecipeData.RecipeDescription] {
        SavedRecipesModel.savedRecipes
    }
    
    func setSaveButtonImage(button: UIButton, recipeID: Int) {
        if SavedRecipesModel.savedRecipes.contains(where: {$0.id == recipeID}) {
            button.isSelected = true
        } else {
            button.isSelected = false
        }
    }
}
