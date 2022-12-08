//
//  TabBar.swift
//  CookBook
//
//  Created by vasily on 02.12.2022.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomePage(), title: "Home", image: UIImage(named: "Home")!, selectedImage: UIImage(named: "HomeSelected")!),
            createNavController(for: MealTypesVC(), title: "Category", image: UIImage(named: "Category")!, selectedImage: UIImage(named: "CategorySelected")!),
            createNavController(for: SearchVC(), title: "Search", image: UIImage(named: "Search")!, selectedImage: UIImage(named: "SearchSelected")!),
        ]
    }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return navController
    }
}
