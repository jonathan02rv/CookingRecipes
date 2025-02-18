//
//  RecipesListController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/9/25.
//

import UIKit
import Combine
import Domain
import DataRecipes

class RecipesListController: UIViewController {

    // MARK: - CustomView

    private let customView: RecipesListViewProtocol
    
    // MARK: - Properties

    var viewModel: RecipesListViewModelProtocol?
    var router: RecipesListRoutingLogic?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recetas"
        setupView()
        setupBindings()
        router?.startLoading()
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
                self?.router?.stopLoading()
                self?.customView.reloadRows(data: recipes)
            })
            .store(in: &cancellables)
    }

}

// MARK: - RecipesListViewDelegate

extension RecipesListController: RecipesListViewDelegate {

    func didSelectRowRecipe(rowData: RecipeModel) {
        router?.routeToRecipeDetail(with: rowData)
    }

}
