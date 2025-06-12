//
//  RecipesMapRepository.swift
//  DataRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

public protocol RecipesMapDataSourceProtocol {
    func fetchRecipesLocations(path: String) async throws -> [RecipeMapEntity]
}

public class RecipesMapRepository: RecipesMapRepositoryProtocol {

    let dataSource: RecipesMapDataSourceProtocol

    public init(dataSource: RecipesMapDataSourceProtocol = URLSessionDataSource()) {
        self.dataSource = dataSource
    }

    public func fetchRecipesLocations() async throws -> [RecipeMapBusinessModel] {
        do {
            let path = "/recipeslocations"
            let data = try await dataSource.fetchRecipesLocations(path: path)
            return RecipeMapEntity.mapper(data: data)
        } catch {
            guard let errorResponse = (error as? ErrorRequest) else {
                throw ErrorRequest.unknown.getTypeError()
            }
            throw errorResponse.getTypeError()
        }
    }

}
