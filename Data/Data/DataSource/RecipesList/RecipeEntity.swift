//
//  RecipeEntity.swift
//  Data
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

public struct RecipeEntity: Decodable {
    let name: String
    let origin: String
    let latitude: Float
    let longitude: Float
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case origin
        case latitude
        case longitude
        case imageUrl
    }
}

extension RecipeEntity {
    static func mapper(data: [RecipeEntity]) -> [RecipeBusinessModel] {
        data.map {
            RecipeBusinessModel(
                name: $0.name,
                origin: $0.origin,
                latitude: $0.latitude,
                longitude: $0.longitude,
                imageUrl: $0.imageUrl
            )
        }
    }
    
}


enum ErrorRequest: String, Error {
    case badURL
    case parseError
    case netWorkError
    case unknown

    func getTypeError() -> ErrorType {
        return ErrorType(rawValue: self.rawValue) ?? .generic
    }
}
