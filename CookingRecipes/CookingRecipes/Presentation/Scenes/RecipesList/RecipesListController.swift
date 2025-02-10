//
//  RecipesListController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit

class RecipesListController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesListViewProtocol
    
    // MARK: - Properties

    private var recipes: [Recipe] = [
        Recipe(name: "Paella", origin: "España", latitude: 39.4699, longitude: -0.3763, imageUrl: "https://example.com/paella.jpg"),
        Recipe(name: "Sushi", origin: "Japón", latitude: 35.6895, longitude: 139.6917, imageUrl: "https://example.com/sushi.jpg"),
        Recipe(name: "Tacos", origin: "México", latitude: 19.4326, longitude: -99.1332, imageUrl: "https://example.com/tacos.jpg")
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recetas"
        setupView()
    }

    init(view: RecipesListViewProtocol) {
        self.customView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func setupView() {
        guard let contentView = self.customView as? UIView else { return }
        self.view = contentView
        customView.delegate = self
        customView.reloadRows(data: recipes)
    }

}

// MARK: - RecipesListViewDelegate

extension RecipesListController: RecipesListViewDelegate {

    func didSelectRowRecipe(rowData: Recipe) {
        let view = RecipesDetailView()
        let detailVC = RecipesDetailController(view: view, recipe: rowData)
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
