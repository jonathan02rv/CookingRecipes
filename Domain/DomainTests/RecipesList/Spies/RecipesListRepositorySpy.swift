//
//  RecipesListRepositorySpy.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

@testable import Domain

class RecipesListRepositorySpy: RecipesListRepositoryProtocol {

    var requestFailed = false
    var fetchRecipesCalled = false

    func fetchRecipes() async throws -> [RecipeBusinessModel] {
        fetchRecipesCalled = true
        if requestFailed {
            throw ErrorType.generic
        } else {
            return [RecipeBusinessModel]()
        }
    }

}
