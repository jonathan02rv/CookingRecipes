//
//  RecipesDetailView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

protocol RecipesDetailViewProtocol {
    func fillContent(data: Recipe)
}

final class RecipesDetailView: UIView {

    // MARK: - Views

    let nameLabel = UILabel()
    let originLabel = UILabel()
    let mapButton = UIButton(type: .system)
    let stackView = UIStackView()

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
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center

        originLabel.font = UIFont.systemFont(ofSize: 18)
        originLabel.textAlignment = .center

        mapButton.setTitle("Ver en el mapa", for: .normal)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(mapButton)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}

// MARK: - RecipesDetailViewProtocol

extension RecipesDetailView: RecipesDetailViewProtocol {

    func fillContent(data: Recipe) {
        nameLabel.text = data.name
        originLabel.text = "Origen: \(data.origin)"
    }

}
