//
//  RecipesListUseCase.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation

public protocol RecipesListUseCaseDelegate: AnyObject {
    func reloadRecipes(recipes: [RecipeBusinessModel])
    func handleError(errorType: ErrorType)
}

public protocol RecipesListUseCaseProtocol {
    var delegate: RecipesListUseCaseDelegate? { get }
    func fetchRecipes()
}

public class RecipesListUseCase: RecipesListUseCaseProtocol {

    var recipes = [RecipeBusinessModel]()

    public weak var delegate: RecipesListUseCaseDelegate?
    let repository: RecipesListRepositoryProtocol

    public init(repository: RecipesListRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchRecipes() {
        Task {
            do {
                let recipesModel = try await repository.fetchRecipes()
                recipes = recipesModel
                print("recipesModel Domain: \(recipesModel)")
                delegate?.reloadRecipes(recipes: recipesModel)
            } catch {
                let errorType = (error as? ErrorType)
                delegate?.handleError(errorType: errorType ?? .generic)
            }
        }
    }

}
