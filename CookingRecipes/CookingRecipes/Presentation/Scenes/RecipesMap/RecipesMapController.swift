//
//  RecipesMapController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit

class RecipesMapController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesMapViewProtocol

    // MARK: - Properties

    let recipes: [RecipeModel]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        setupView()
    }

    init(view: RecipesMapViewProtocol, recipes: [RecipeModel]) {
        self.customView = view
        self.recipes = recipes
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func setupView() {
        guard let contentView = self.customView as? UIView else { return }
        self.view = contentView
        customView.setLocations(recipes: recipes)
    }

}

// MARK: - Builder

extension RecipesMapController {
    class func buildRecipesMapController() -> RecipesMapController {
        let recipes: [RecipeModel] = [
            RecipeModel(name: "Paella", origin: "España", latitude: 39.4699, longitude: -0.3763, imageUrl: "https://example.com/paella.jpg"),
            RecipeModel(name: "Sushi", origin: "Japón", latitude: 35.6895, longitude: 139.6917, imageUrl: "https://example.com/sushi.jpg"),
            RecipeModel(name: "Tacos", origin: "México", latitude: 19.4326, longitude: -99.1332, imageUrl: "https://example.com/tacos.jpg")
        ]
        let view = RecipesMapView()
        let controller = RecipesMapController(view: view, recipes: recipes)
        return controller
    }
}
