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

    let recipe: Recipe

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Receta Detalle"
        setupView()
    }

    init(view: RecipesDetailViewProtocol, recipe: Recipe) {
        self.customView = view
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func setupView() {
        guard let contentView = self.customView as? UIView else { return }
        self.view = contentView
        customView.fillContent(data: recipe)
    }

}
