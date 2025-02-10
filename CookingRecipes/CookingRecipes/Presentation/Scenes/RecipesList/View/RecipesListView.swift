//
//  RecipesListView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

protocol RecipesListViewDelegate: AnyObject {
    func didSelectRowRecipe(rowData: Recipe)
}

protocol RecipesListViewProtocol: NSObjectProtocol {
    var delegate: RecipesListViewDelegate? { get set }
    func reloadRows(data: [Recipe])
}

final class RecipesListView: UIView {

    // MARK: - Views

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    // MARK: - Properties

    private var filteredRecipes: [Recipe] = []
    private var allRecipes: [Recipe] = []
    weak var delegate: RecipesListViewDelegate?

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Functions

    private func setupView() {
        addSubview(searchBar)
        addSubview(tableView)
        setupSearchBarView()
        setupTableview()
        setupConstraints()
    }

    func setupSearchBarView() {
        searchBar.placeholder = "Busca tu receta..."
        searchBar.delegate = self
    }
    func setupTableview() {
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
    }

    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}

// MARK: - UISearchBarDelegate

extension RecipesListView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource

extension RecipesListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredRecipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
        cell.configure(with: filteredRecipes[indexPath.row])
        return cell
    }

}

// MARK: - UITableViewDelegate

extension RecipesListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipeSelected = filteredRecipes[indexPath.row]
        delegate?.didSelectRowRecipe(rowData: recipeSelected)
    }

}

// MARK: - RecipesListViewProtocol

extension RecipesListView: RecipesListViewProtocol {

    func reloadRows(data: [Recipe]) {
        allRecipes = data
        filteredRecipes = allRecipes
        tableView.reloadData()
    }

}
