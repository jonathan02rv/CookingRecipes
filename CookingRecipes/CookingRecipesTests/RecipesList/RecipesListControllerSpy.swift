//
//  RecipesListControllerSpy.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit
@testable import CookingRecipes
@testable import Domain

class RecipesListUseCaseSpy: RecipesListUseCaseProtocol {

    var fetchRecipesCalled = false
    weak var delegate: RecipesListUseCaseDelegate?

    func fetchRecipes() {
        fetchRecipesCalled = true
    }

}
