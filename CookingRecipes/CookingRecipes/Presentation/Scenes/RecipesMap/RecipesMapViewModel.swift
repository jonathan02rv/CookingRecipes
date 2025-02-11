//
//  RecipesMapViewModel.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain
import Foundation
import Combine

protocol RecipesMapViewModelProtocol {
    var fillContentView: PassthroughSubject<[RecipesMapModel], Never> { get }
    func fetchRecipesLocations()
}

class RecipesMapViewModel: RecipesMapViewModelProtocol {

    // MARK: - Binders

    let fillContentView: PassthroughSubject<[RecipesMapModel], Never> = PassthroughSubject()

    // MARK: - Properties

    let useCase: RecipesListUseCaseProtocol

    // MARK: - Lifecycle

    init (useCase: RecipesListUseCaseProtocol) {
        self.useCase = useCase
    }

    // MARK: - Functions

    func fetchRecipesLocations() {
        useCase.fetchRecipes()
    }

}

extension RecipesMapViewModel: RecipesMapUseCaseDelegate {

    func handleError(errorType: ErrorType) {
        print("ErrorType VM: \(errorType)")
    }

    func reloadRecipesLocations(recipes: [RecipeMapBusinessModel]) {
        let recipesViewData: [RecipesMapModel] = recipes.map {
            RecipesMapModel(name: $0.name, origin: $0.origin, latitude: $0.latitude, longitude: $0.longitude)
        }
        fillContentView.send(recipesViewData)
    }

}
