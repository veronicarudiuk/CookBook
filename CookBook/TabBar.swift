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
        setupVCs()
    }
    
    
    func setupVCs() {
          viewControllers = [
              createNavController(for: HomePage(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
              createNavController(for: MealTypesVC(), title: NSLocalizedString("Category", comment: ""), image: UIImage(systemName: "list.bullet.rectangle")!),
          ]
      }
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
