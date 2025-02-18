//
//  RecipeCell.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit

class RecipeCell: UITableViewCell {

    // MARK: - Identifier cell view

    static let reuseIdentifier = "RecipeCell"

    // MARK: - Properties

    var imageCache = NSCache<NSString, UIImage>()

    // MARK: - Views

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

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(recipeImageView)
        contentView.addSubview(recipeNameLabel)

        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            recipeImageView.widthAnchor.constraint(equalToConstant: 50),
            recipeImageView.heightAnchor.constraint(equalToConstant: 40),

            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            recipeNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: RecipeModel) {
        recipeNameLabel.text = recipe.name
        loadImage(from: recipe.imageUrl)
    }

    // MARK: - Function

    private func loadImage(from urlString: String) {
        if let image = imageCache.object(forKey: urlString as NSString){
            recipeImageView.image = image
            return
        }
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else { return }
            imageCache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async { [weak self] in
                self?.recipeImageView.image = image
            }
        }
        task.resume()
    }

}
