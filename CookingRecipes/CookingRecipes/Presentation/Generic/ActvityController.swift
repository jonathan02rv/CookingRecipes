//
//  ActvityController.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/18/25.
//

import UIKit

final class ActvityController: UIViewController {

    // MARK: - View

    let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVew()
        setupConstraints()
    }

    // MARK: - Functions

    private func setupVew() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        view.addSubview(activityIndicator)
        activityIndicator.color = .systemBlue
    }

    private func setupConstraints() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
    }

}
