//
//  RecipesListModel.swift
//  CookingRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation
import CoreLocation

struct Recipe {
    let name: String
    let origin: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
