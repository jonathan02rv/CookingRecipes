//
//  RecipesDetailViewModel.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/18/25.
//

import Foundation

protocol RecipesDetailViewModelProtocol {
    func getRecipeModel() -> RecipeModel
}

final class RecipesDetailViewModel {

    // MARK: - Properties

    private let recipeModel: RecipeModel

    // MARK: - Lifecycle

    init (recipeModel: RecipeModel) {
        self.recipeModel = recipeModel
    }

}

// MARK: - RecipesDetailViewModelProtocol

extension RecipesDetailViewModel: RecipesDetailViewModelProtocol {

    func getRecipeModel() -> RecipeModel {
        self.recipeModel
    }

}
