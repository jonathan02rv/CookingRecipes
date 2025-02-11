//
//  RecipesListRouter.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation
import Domain
import DataRecipes

protocol RecipesListRoutingLogic  {
    func routeToRecipeDetail(with recipe: RecipeModel)
}

class RecipesListRouter: RecipesListRoutingLogic {

    weak var viewController: RecipesListController?

    func routeToRecipeDetail(with recipe: RecipeModel) {
        let view = RecipesDetailView()
        let detailVC = RecipesDetailController(view: view, recipe: recipe)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Factory

extension RecipesListRouter {

    class func buildRecipesListController() -> RecipesListController {
        let view = RecipesListView()
        let controller = RecipesListController(view: view)
        let router = RecipesListRouter()
        let useCase = RecipesListUseCase(repository: RecipesListRepository())
        let viewModel = RecipesListViewModel(useCase: useCase)
        useCase.delegate = viewModel
        controller.viewModel = viewModel
        router.viewController = controller
        controller.router = router
        return controller
    }

}
