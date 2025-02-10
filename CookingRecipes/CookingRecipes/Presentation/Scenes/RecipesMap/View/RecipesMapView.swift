//
//  RecipesMapView.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import UIKit
import MapKit

protocol RecipesMapViewProtocol: NSObjectProtocol {
    func setLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

final class RecipesMapView: UIView {

    private let mapView = MKMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMap()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMap()
    }

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

extension RecipesMapView: RecipesMapViewProtocol {

    func setLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        mapView.setRegion(region, animated: true)
    }

}
