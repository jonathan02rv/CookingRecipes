//
//  RecipesMapEntity.swift
//  DataRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

public struct RecipeMapEntity: Decodable {
    let name: String
    let origin: String
    let latitude: Float
    let longitude: Float

    enum CodingKeys: String, CodingKey {
        case name
        case origin
        case latitude
        case longitude
    }
}

extension RecipeMapEntity {
    static func mapper(data: [RecipeMapEntity]) -> [RecipeMapBusinessModel] {
        data.map {
            RecipeMapBusinessModel(
                name: $0.name,
                origin: $0.origin,
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
    }

}
