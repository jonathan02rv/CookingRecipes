//
//  RecipesListViewModelSpy.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

@testable import Domain

class RecipesListViewModelSpy: RecipesListUseCaseDelegate {

    var reloadRecipesCalled = false
    var handleErrorCalled = false

    func reloadRecipes(recipes: [RecipeBusinessModel]) {
        reloadRecipesCalled = true
    }
    
    func handleError(errorType: ErrorType) {
        handleErrorCalled = true
    }

}
