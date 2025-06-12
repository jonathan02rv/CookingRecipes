//
//  RecipesDetailController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

class RecipesDetailController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesDetailViewProtocol

    // MARK: - Properties

    var viewModel: RecipesDetailViewModelProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Receta Detalle"
        setupView()
    }

    init(view: RecipesDetailViewProtocol) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func setupView() {
        guard let contentView = self.customView as? UIView else { return }
        self.view = contentView
        guard let recipeModel = viewModel?.getRecipeModel() else { return }
        customView.fillContent(data: recipeModel)
        customView.delegate = self
    }

}

extension RecipesDetailController: RecipesDetailViewDelegate {

    func displayMap(recipe: RecipesMapModel) {
        let view = RecipesMapView()
        let mapVC = RecipesMapController(view: view, recipes: [recipe])
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
}
