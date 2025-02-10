//
//  RecipesMainTabBarController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit

class RecipesMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    func setupView() {
        let recipeListVC = UINavigationController(rootViewController: RecipesListController.buildRecipesListController())
        recipeListVC.tabBarItem = UITabBarItem(title: "Recetas", image: UIImage(systemName: "list.bullet"), tag: 0)

        let mapVC = UINavigationController(rootViewController: RecipesMapController.buildRecipesMapController())
        mapVC.tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(systemName: "map"), tag: 1)
        viewControllers = [recipeListVC, mapVC]
    }

}

// MARK: - Builder

extension RecipesMainTabBarController {

    class func buildRecipesMainTabBarController() -> RecipesMainTabBarController {
        let controller = RecipesMainTabBarController()
        return controller
    }

}
