//
//  RecipesListController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit

class RecipesListController: UIViewController {

    var customView: (UIView & RecipesListViewProtocol)?
    var recipes: [Recipe] = [
            Recipe(name: "Paella", origin: "España", latitude: 39.4699, longitude: -0.3763),
            Recipe(name: "Sushi", origin: "Japón", latitude: 35.6895, longitude: 139.6917)
        ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recetas"
        view.backgroundColor = .yellow
        setupView()
    }

    init(view: (RecipesListView & RecipesListViewProtocol)) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Functions

    func setupView() {
        guard let contentView = customView else { return }
        self.view = contentView
        customView?.delegate = self
        customView?.reloadRows(data: recipes)
    }

}

// MARK: - RecipesListViewDelegate

extension RecipesListController: RecipesListViewDelegate {

    func didSelectRowRecipe(rowData: Recipe) {
         let detailVC = RecipesDetailController()
         navigationController?.pushViewController(detailVC, animated: true)
    }

}

// MARK: - Builder

extension RecipesListController {
    class func buildRecipesListController() -> RecipesListController {
        let view = RecipesListView()
        let controller = RecipesListController(view: view)
        return controller
    }
}
