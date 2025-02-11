//
//  RecipesMapRouter.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation
import Domain
import DataRecipes

protocol RecipesMapRoutingLogic  {

}

class RecipesMapRouter: RecipesMapRoutingLogic {

    // MARK: - Factory

    class func buildRecipesMapController() -> RecipesMapController {
        let view = RecipesMapView()
        let controller = RecipesMapController(view: view, recipes: [])
        let useCase = RecipesMapUseCase(repository: RecipesMapRepository())
        let viewModel = RecipesMapViewModel(useCase: useCase)
        controller.viewModel = viewModel
        useCase.delegate = viewModel
        return controller
    }

}
