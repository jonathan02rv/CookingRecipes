//
//  RecipesMapView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit
import MapKit

protocol RecipesMapViewProtocol: NSObjectProtocol {
    func setLocations(recipes: [RecipeModel])
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

    func setLocations(recipes: [RecipeModel]) {
        var annotations: [MKPointAnnotation] = []
        recipes.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = $0.name
            annotation.subtitle = "Origen: \($0.origin)"
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
        if !annotations.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.mapView.showAnnotations(annotations, animated: true)
            }
        }
    }

}
