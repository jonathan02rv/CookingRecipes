//
//  RecipesMapRepositoryProtocol.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

public protocol RecipesMapRepositoryProtocol {
    func fetchRecipesLocations() async throws -> [RecipeMapBusinessModel]
}
