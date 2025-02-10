//
//  RecipeBusinessModel.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

public struct RecipeBusinessModel {
    public let name: String
    public let origin: String
    public let latitude: Float
    public let longitude: Float
    public let imageUrl: String

    public init(name: String, origin: String, latitude: Float, longitude: Float, imageUrl: String) {
        self.name = name
        self.origin = origin
        self.latitude = latitude
        self.longitude = longitude
        self.imageUrl = imageUrl
    }
}
