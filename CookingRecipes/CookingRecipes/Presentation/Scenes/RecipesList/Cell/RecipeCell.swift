//
//  RecipeCell.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

class RecipeCell: UITableViewCell {

    static let reuseIdentifier = "RecipeCell"

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(recipeImageView)
        contentView.addSubview(recipeNameLabel)

        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 50),
            recipeImageView.heightAnchor.constraint(equalToConstant: 50),

            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            recipeNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: Recipe) {
        recipeNameLabel.text = recipe.name
        loadImage(from: recipe.imageUrl)
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
