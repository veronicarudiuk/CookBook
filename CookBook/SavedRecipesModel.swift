//
//  Constants.swift
//  CookBook
//
//  Created by Veronica Rudiuk on 2.12.22.
//

import Foundation

struct SavedRecipesModel {
    
    static var savedRecipes = [716429]
    
    mutating func saveNewRecipe(id: Int) {
        SavedRecipesModel.savedRecipes.append(id)
    }
    
    mutating func deleteRecipeFromSaved(id: Int) {
        if let index = SavedRecipesModel.savedRecipes.firstIndex(of: id) {
            SavedRecipesModel.savedRecipes.remove(at: index)
        }
    }
    
    func getSavedRecipesList() -> [Int] {
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
