//
//  RecipesMapUseCase.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation

public protocol RecipesMapUseCaseDelegate: AnyObject {
    func reloadRecipesLocations(recipes: [RecipeMapBusinessModel])
    func handleError(errorType: ErrorType)
}

public protocol RecipesMapUseCaseProtocol {
    var delegate: RecipesMapUseCaseDelegate? { get }
    func fetchRecipesLocations()
}

public class RecipesMapUseCase: RecipesMapUseCaseProtocol {

    var recipes = [RecipeMapBusinessModel]()

    public weak var delegate: RecipesMapUseCaseDelegate?
    let repository: RecipesMapRepositoryProtocol

    public init(repository: RecipesMapRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchRecipesLocations() {
        Task {
            do {
                let recipesModel = try await repository.fetchRecipes()
                recipes = recipesModel
                print("recipesModel Domain: \(recipesModel)")
                delegate?.reloadRecipesLocations(recipes: recipesModel)
            } catch {
                let errorType = (error as? ErrorType)
                delegate?.handleError(errorType: errorType ?? .generic)
            }
        }
    }

}
