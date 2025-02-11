//
//  RecipesMapController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit
import Combine
import Domain
import DataRecipes

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
        let view = RecipesMapView()
        let controller = RecipesMapController(view: view, recipes: [])
        let useCase = RecipesMapUseCase(repository: RecipesMapRepository())
        let viewModel = RecipesMapViewModel(useCase: useCase)
        controller.viewModel = viewModel
        useCase.delegate = viewModel
        return controller
    }
}
