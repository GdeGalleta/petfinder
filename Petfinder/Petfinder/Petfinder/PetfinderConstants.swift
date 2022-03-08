//
//  PetfinderConstants.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import Foundation
import MapKit
import UIKit.UIColor

public struct K {
    public static let defaultLocation = CLLocationCoordinate2D(latitude: 40.778532, longitude: -73.957451)
    public static let testMode = "testMode"
    public struct Color {
        public static let background: UIColor = .black
        public static let textLight: UIColor = .white
        public static let textDark: UIColor = .black
    }
    public struct AccessIden {
        public static let tabBarButtonAnimalList = "tabBarButtonAnimalList"
        public static let tabBarButtonOrganizations = "tabBarButtonOrganizations"
    }
}
