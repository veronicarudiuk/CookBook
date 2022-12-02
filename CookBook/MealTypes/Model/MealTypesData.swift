//
//  MealTypesData.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

struct MealTypesData {
    let title: String
    let image = #imageLiteral(resourceName: "mealDefaultBackgroundOne")
}

let mealsdata: [MealTypesData] = [
    MealTypesData(title: "Main course"),
    MealTypesData(title: "Side dish"),
    MealTypesData(title: "Dessert"),
    MealTypesData(title: "Appetizer"),
    MealTypesData(title: "Salad"),
    MealTypesData(title: "Bread"),
    MealTypesData(title: "Breakfast"),
    MealTypesData(title: "Soup"),
    MealTypesData(title: "Beverage"),
    MealTypesData(title: "Sauce"),
    MealTypesData(title: "Marinade"),
    MealTypesData(title: "Fingerfood"),
    MealTypesData(title: "Snack"),
    MealTypesData(title: "Drink")
]

let mealTypesCount = mealsdata.count
