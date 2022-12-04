//
//  RecipeNetworkManager.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//
import Foundation

//MARK: RecipeNetworkManagerDelegate
protocol RecipeNetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData)
    func didFailWithError(error: Error)
}

//MARK: Types of request
enum RequestType {
    case random, categories, find
}


//MARK: - Data parser by URL
struct RecipeNetworkManager {
    private let urlApi = "https://api.spoonacular.com"
    var delegate: RecipeNetworkManagerDelegate?
    
    func getRecipes(_ requestType: RequestType, tag: String? = nil) {
        let urlString = currentUrl(requestType, tag: tag)
        
        guard let url = URL(string: urlString) else { return  }
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let recipes = try JSONDecoder().decode(RecipeData.self, from: data)
                self.delegate?.RecipesDidRecive(recipes)
            } catch let error {
                print("Error: \(error)")
                self.delegate?.didFailWithError(error: error)
            }
        }.resume()
    }
    
    //MARK: - Private current URL method
    private func currentUrl(_ forRequest: RequestType, tag: String? = nil) -> String {
        var url = String()
        switch forRequest {
        case .random:
            url = "https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=\(ApiKey.api.rawValue)&type=random"
        case .categories:
            if let tag = tag?.lowercased() {
                let type = tag.replacingOccurrences(of: " ", with: "+")
                url = "https://api.spoonacular.com/recipes/complexSearch?number=10&instructionsRequired=true&addRecipeInformation=true&fillIngredients=true&apiKey=\(ApiKey.api.rawValue)&type=\(type)"
            }
        case .find:
            break // запрос на поиск
        }
        return url
    }
}
