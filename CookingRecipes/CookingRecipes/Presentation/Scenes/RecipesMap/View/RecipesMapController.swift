//
//  RecipesMapController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit
import Combine

class RecipesMapController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesMapViewProtocol

    // MARK: - Properties

    var viewModel: RecipesMapViewModelProtocol?
    private var cancellables = Set<AnyCancellable>()

    let recipes: [RecipesMapModel]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        setupView()
        setupBindings()
        viewModel?.fetchRecipesLocations()
    }

    init(view: RecipesMapViewProtocol, recipes: [RecipesMapModel]) {
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

    func setupBindings() {
        viewModel?.fillContentView
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] recipes in
                self?.customView.setLocations(recipes: recipes)
            })
            .store(in: &cancellables)
    }

}

// MARK: - Builder

extension RecipesMapController {
    class func buildRecipesMapController() -> RecipesMapController {
        let recipes: [RecipesMapModel] = [
            RecipesMapModel(name: "Paella", origin: "España", latitude: 39.4699, longitude: -0.3763),
            RecipesMapModel(name: "Sushi", origin: "Japón", latitude: 35.6895, longitude: 139.6917),
            RecipesMapModel(name: "Tacos", origin: "México", latitude: 19.4326, longitude: -99.1332)
        ]
        let view = RecipesMapView()
        let controller = RecipesMapController(view: view, recipes: recipes)
        return controller
    }
}
