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
    var fillContentView: PassthroughSubject<[Recipe], Never> { get }
    func fetchRecipes()
}

class RecipesListViewModel: RecipesListViewModelProtocol {

    // MARK: - Binders

    let fillContentView: PassthroughSubject<[Recipe], Never> = PassthroughSubject()

    let useCase: RecipesListUseCaseProtocol

    init (useCase: RecipesListUseCaseProtocol) {
        self.useCase = useCase
    }

    func fetchRecipes() {
        useCase.fetchRecipes()
    }

}

extension RecipesListViewModel: RecipesListUseCaseDelegate {
    func reloadRecipes(recipes: [RecipeModel]) {
        let recipesViewData: [Recipe] = recipes.map {
            Recipe(name: $0.name, origin: $0.origin, latitude: $0.latitude, longitude: $0.longitude, imageUrl: $0.imageUrl)
        }
        fillContentView.send(recipesViewData)
    }
    

}
