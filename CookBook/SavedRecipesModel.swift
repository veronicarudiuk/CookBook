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
    //    mutating func deleteRecipeFromSaved(id: RecipeData.RecipeDescription) {
    //        if let index = SavedRecipesModel.savedRecipes.firstIndex(of: id) {
    //            SavedRecipesModel.savedRecipes.remove(at: index)
    //        }
    //    }
    
    func getSavedRecipesList() -> [RecipeData.RecipeDescription] {
        SavedRecipesModel.savedRecipes
    }
}





//// Добавление рецептов в глобальную переменную
////Это для первичной инициализации пустого массива, не знаю как сделать по другому
//     if Constants.savedRecipes.isEmpty {
////         /сюда тип данных RecipeData.RecipeDescription/
//         Constants.savedRecipes =
//     } else {
////         /сюда тип данных RecipeData.RecipeDescription/
//         Constants.savedRecipes.append()
//     }
//
////  Удаление по индексу, перед этим нужна проверка на outOfRange.error
//
//     Constants.savedRecipes.remove(at: <#T##Int#>)
