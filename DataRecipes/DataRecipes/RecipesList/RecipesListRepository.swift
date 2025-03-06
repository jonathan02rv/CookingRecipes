//
//  RecipesListRepository.swift
//  Data
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

public protocol RecipesListDataSourceProtocol {
    func fetchRecipes(path: String) async throws -> [RecipeEntity]
}

public class RecipesListRepository: RecipesListRepositoryProtocol {

    let dataSource: RecipesListDataSourceProtocol

    public init(dataSource: RecipesListDataSourceProtocol = URLSessionDataSource()) {
        self.dataSource = dataSource
    }

    public func fetchRecipes() async throws -> [RecipeBusinessModel] {
        do {
            let path = "/v3/21f6e139-be2d-4bd9-b10a-fe1611639c45"
            let data = try await dataSource.fetchRecipes(path: path)
            return RecipeEntity.mapper(data: data)
        } catch {
            guard let errorResponse = (error as? ErrorRequest) else {
                throw ErrorRequest.unknown.getTypeError()
            }
            throw errorResponse.getTypeError()
        }
    }

}
