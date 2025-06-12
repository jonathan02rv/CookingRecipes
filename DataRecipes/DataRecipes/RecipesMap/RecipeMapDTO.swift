//
//  RecipeMapDTO.swift
//  DataRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

public struct RecipeMapDTO: Decodable {
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

extension RecipeMapDTO {
    static func mapper(data: [RecipeMapDTO]) -> [RecipeMapBusinessEntity] {
        data.map {
            RecipeMapBusinessEntity(
                name: $0.name,
                origin: $0.origin,
                latitude: $0.latitude,
                longitude: $0.longitude
            )
        }
    }

}
