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
            let path = "/v3/ca8b38f2-8557-43e5-92f7-d84b3e678f99"
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
