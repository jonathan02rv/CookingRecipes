//
//  RecipeMapBusinessModel.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

public struct RecipeMapBusinessModel {
    public let name: String
    public let origin: String
    public let latitude: Float
    public let longitude: Float

    public init(name: String, origin: String, latitude: Float, longitude: Float) {
        self.name = name
        self.origin = origin
        self.latitude = latitude
        self.longitude = longitude
    }
}
