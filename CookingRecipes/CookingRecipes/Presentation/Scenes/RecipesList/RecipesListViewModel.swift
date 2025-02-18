//
//  RecipesListViewModel.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain
import Foundation
import Combine

protocol RecipesListViewModelProtocol {
    var fillContentView: PassthroughSubject<[RecipeModel], Never> { get }
    func fetchRecipes()
}

class RecipesListViewModel: RecipesListViewModelProtocol {

    // MARK: - Binders

    let fillContentView: PassthroughSubject<[RecipeModel], Never> = PassthroughSubject()

    // MARK: - Properties

    let useCase: RecipesListUseCaseProtocol

    // MARK: - Lifecycle

    init (useCase: RecipesListUseCaseProtocol) {
        self.useCase = useCase
    }

    // MARK: - Functions

    func fetchRecipes() {
        useCase.fetchRecipes()
    }

}

// MARK: - RecipesListUseCaseDelegate

extension RecipesListViewModel: RecipesListUseCaseDelegate {
    
    func handleError(errorType: ErrorType) {
        print("ErrorType VM: \(errorType)")
    }
    
    func reloadRecipes(recipes: [RecipeBusinessModel]) {
        let recipesViewData: [RecipeModel] = recipes.map {
            RecipeModel(name: $0.name, origin: $0.origin, latitude: $0.latitude, longitude: $0.longitude, imageUrl: $0.imageUrl)
        }
        fillContentView.send(recipesViewData)
    }

}
