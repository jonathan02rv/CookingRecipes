//
//  RecipesDetailView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

protocol RecipesDetailViewDelegate: AnyObject {
    func displayMap(recipe: RecipesMapModel)
}

protocol RecipesDetailViewProtocol: NSObjectProtocol {
    var delegate: RecipesDetailViewDelegate? { get set }
    func fillContent(data: RecipeModel)
}

final class RecipesDetailView: UIView {

    // MARK: - Views

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let originLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver en el mapa", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Properties

    var recipe: RecipeModel?
    weak var delegate: RecipesDetailViewDelegate?

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
        stackView.addArrangedSubview(recipeNameLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(mapButton)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(recipeImageView)
        addSubview(stackView)
        setupConstraints()
        mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            recipeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 200),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc func mapButtonTapped() {
        guard let recipe = self.recipe else { return }
        let mapRecipe = RecipesMapModel(name: recipe.name, origin: recipe.origin, latitude: recipe.latitude, longitude: recipe.longitude)
        delegate?.displayMap(recipe: mapRecipe)
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.recipeImageView.image = image
                }
            }
        }
    }

}

// MARK: - RecipesDetailViewProtocol

extension RecipesDetailView: RecipesDetailViewProtocol {

    func fillContent(data: RecipeModel) {
        recipeNameLabel.text = data.name
        originLabel.text = "Origen: \(data.origin)"
        loadImage(from: data.imageUrl)
        self.recipe = data
    }

}
