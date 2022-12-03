//
//  Constants.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 2.12.22.
//

import Foundation

struct SavedRecipesModel {
    
    static var savedRecipes = [RecipeData.RecipeDescription]()
    
    mutating func saveNewRecipe(_ recipeData: [RecipeData.RecipeDescription]) {
        if SavedRecipesModel.savedRecipes.isEmpty {
            SavedRecipesModel.savedRecipes = [recipeData[0]]
        } else {
            SavedRecipesModel.savedRecipes.append(recipeData[0])
        }
    }
    
    mutating func deleteRecipeFromSaved(_ recipeData: [RecipeData.RecipeDescription]) {
        let recipeID = recipeData[0].id
        SavedRecipesModel.savedRecipes.removeAll(where: {$0.id == recipeID})
    }
    
    func getSavedRecipesList() -> [RecipeData.RecipeDescription] {
        SavedRecipesModel.savedRecipes
    }
}
