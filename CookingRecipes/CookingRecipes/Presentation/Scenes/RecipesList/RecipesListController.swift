//
//  RecipesListController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit
import Combine
import Domain
import Data

class RecipesListController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesListViewProtocol
    
    // MARK: - Properties

    var viewModel: RecipesListViewModelProtocol?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recetas"
        setupView()
        setupBindings()
        viewModel?.fetchRecipes()
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
    }

    func setupBindings() {
        viewModel?.fillContentView
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] recipes in
                self?.customView.reloadRows(data: recipes)
            })
            .store(in: &cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchRecipes()
    }

}

// MARK: - RecipesListViewDelegate

extension RecipesListController: RecipesListViewDelegate {

    func didSelectRowRecipe(rowData: RecipeModel) {
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
        let useCase = RecipesListUseCase(repository: RecipesListRepository())
        let viewModel = RecipesListViewModel(useCase: useCase)
        useCase.delegate = viewModel
        controller.viewModel = viewModel
        return controller
    }
}
