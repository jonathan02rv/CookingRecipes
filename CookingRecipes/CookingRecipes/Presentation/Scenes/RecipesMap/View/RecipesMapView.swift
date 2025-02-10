//
//  RecipesMapView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit
import MapKit

protocol RecipesMapViewProtocol: NSObjectProtocol {
    func setLocation(recipe: Recipe)
}

final class RecipesMapView: UIView {

    // MARK: - Views

    private let mapView = MKMapView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMap()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMap()
    }

    // MARK: - Functions

    private func setupMap() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}

// MARK: - RecipesMapViewProtocol

extension RecipesMapView: RecipesMapViewProtocol {

    func setLocation(recipe: Recipe) {
        let coordinate = CLLocationCoordinate2D(latitude: recipe.latitude, longitude: recipe.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = recipe.name
        annotation.subtitle = "Origen: \(recipe.origin)"
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        mapView.setRegion(region, animated: true)
    }

}
