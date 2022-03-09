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
        public static let backgroundDark: UIColor = UIColor.init(named: "background_dark") ?? .black
        public static let backgroundLight: UIColor = UIColor.init(named: "background_light") ?? .darkGray
        public static let textDark: UIColor = UIColor.init(named: "text_dark") ?? .yellow
        public static let textLight: UIColor = UIColor.init(named: "text_light") ?? .cyan
        public static let mapPinColor: UIColor = .cyan
    }
    public struct AccessIden {
        public static let tabBarButtonAnimalList = "tabBarButtonAnimalList"
        public static let tabBarButtonOrganizations = "tabBarButtonOrganizations"
    }
}
