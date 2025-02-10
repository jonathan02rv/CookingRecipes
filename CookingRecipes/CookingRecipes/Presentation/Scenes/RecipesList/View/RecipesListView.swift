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

    // MARK: - Properties

    var recipes: [Recipe] = []
    weak var delegate: RecipesListViewDelegate?

    // MARK: - Views

    private let tableView = UITableView()

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
        addSubview(tableView)
        setupTableview()
        setupConstraints()
    }

    func setupTableview() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension RecipesListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }

}

// MARK: - UITableViewDelegate

extension RecipesListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipeSelected = recipes[indexPath.row]
        delegate?.didSelectRowRecipe(rowData: recipeSelected)
    }

}

// MARK: - RecipesListViewProtocol

extension RecipesListView: RecipesListViewProtocol {

    func reloadRows(data: [Recipe]) {
        recipes = data
        tableView.reloadData()
    }

    func buildView() {
        setupView()
    }

}
