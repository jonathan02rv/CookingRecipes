//
//  RecipesListRouter.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation
import Domain
import DataRecipes
import UIKit

protocol RecipesListRoutingLogic  {
    func routeToRecipeDetail(with recipe: RecipeModel)
    func startLoading()
    func stopLoading()
}

class RecipesListRouter: RecipesListRoutingLogic {

    weak var viewController: RecipesListController?
    private var activityController: ActvityController?

    init(viewController: RecipesListController?) {
        self.viewController = viewController
        setupActivityController()
    }

    func routeToRecipeDetail(with recipe: RecipeModel) {
        let view = RecipesDetailView()
        let viewModel = RecipesDetailViewModel(recipeModel: recipe)
        let detailVC = RecipesDetailController(view: view)
        detailVC.viewModel = viewModel
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }

    func setupActivityController() {
        activityController = ActvityController()
    }

    func startLoading() {
        guard let activityController = activityController else { return }
        activityController.startLoading()
        activityController.modalPresentationStyle = .overFullScreen
        viewController?.navigationController?.present(activityController, animated: false)
    }

    func stopLoading() {
        activityController?.stopLoading()
        activityController?.dismiss(animated: true)
    }

}

// MARK: - Factory

extension RecipesListRouter {

    class func buildRecipesListController() -> RecipesListController {
        let view = RecipesListView()
        let controller = RecipesListController(view: view)
        let router = RecipesListRouter(viewController: controller)
        let useCase = RecipesListUseCase(repository: RecipesListRepository())
        let viewModel = RecipesListViewModel(useCase: useCase)
        useCase.delegate = viewModel
        controller.viewModel = viewModel
        router.viewController = controller
        controller.router = router
        return controller
    }

}
