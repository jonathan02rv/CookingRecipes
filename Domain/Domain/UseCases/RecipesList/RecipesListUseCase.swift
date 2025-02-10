//
//  RecipesListUseCase.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation

public protocol RecipesListUseCaseDelegate: AnyObject {
    func reloadRecipes(recipes: [RecipeModel])
}

public protocol RecipesListUseCaseProtocol {
    var delegate: RecipesListUseCaseDelegate? { get }
    func fetchRecipes()
}

public class RecipesListUseCase: RecipesListUseCaseProtocol {

    var recipes = [RecipeModel]()

    public weak var delegate: RecipesListUseCaseDelegate?

    public init() {}

    public func fetchRecipes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let recipes: [RecipeModel] = [
                RecipeModel(name: "Paella", origin: "España", latitude: 39.4699, longitude: -0.3763, imageUrl: "https://www.cuisinart.com/dw/image/v2/ABAF_PRD/on/demandware.static/-/Sites-us-cuisinart-sfra-Library/default/dwd5637729/images/recipe-Images/tacos-americanos-recipe.jpg"),
                RecipeModel(name: "Sushi", origin: "Japón", latitude: 35.6895, longitude: 139.6917, imageUrl: "https://example.com/sushi.jpg"),
                RecipeModel(name: "Tacos", origin: "México", latitude: 19.4326, longitude: -99.1332, imageUrl: "https://example.com/tacos.jpg")
            ]
            self?.delegate?.reloadRecipes(recipes: recipes)
        }
    }

}
