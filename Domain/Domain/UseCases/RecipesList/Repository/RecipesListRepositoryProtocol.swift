//
//  RecipesListRepositoryProtocol.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

public protocol RecipesListRepositoryProtocol {
    func fetchRecipes() async throws -> [ RecipeBusinessModel]
}
