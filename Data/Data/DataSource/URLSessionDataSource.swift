//
//  URLSessionDataSource.swift
//  Data
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

public class URLSessionDataSource: RecipesListDataSourceProtocol {

    let urlSession = URLSession.shared
    let baseUrl: String

    public init() {
        baseUrl = "https://demo3434909.mockable.io"
    }

    public func fetchRecipes(path: String) async throws -> [RecipeEntity] {
        let urlRequest = baseUrl + path
        guard let url = URL(string: urlRequest) else {
            throw ErrorRequest.badURL
        }
        do {
            let (data, _) = try await urlSession.data(from: url)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print("jsonObject: \(jsonObject)")
            if let moviesResponse = try? JSONDecoder().decode([RecipeEntity].self, from: data) {
                return moviesResponse
            } else {
                print("parseError")
                throw ErrorRequest.parseError
            }
        } catch {
            print("NetworkError")
            throw ErrorRequest.netWorkError
        }
    }

}
