//
//  RecipeNetworkManager.swift
//  CookBook
//
//  Created by Марс Мазитов on 29.11.2022.
//
import Foundation

protocol RecipeNetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData)
    func didFailWithError(error: Error)
}

enum RequestType {
    case random, categories, find
}

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
    
    private func currentUrl(_ forRequest: RequestType, tag: String? = nil) -> String {
        var url = String()
        switch forRequest {
        case .random:
            url = "https://api.spoonacular.com/recipes/random?&number=10&apiKey=\(ApiKey.api.rawValue)"
        case .categories:
            if let tag = tag?.lowercased() {
                print(tag)
                url = "https://api.spoonacular.com/recipes/random?&number=10&limitLicense=true&apiKey=\(ApiKey.api.rawValue)&tag=\(tag)"
                print(url)
            }
        case .find:
            break // запрос на поиск
        }
        return url
    }
}
