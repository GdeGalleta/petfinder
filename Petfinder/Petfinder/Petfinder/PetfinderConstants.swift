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
    public static let defaultDistance = 10
    public static let testMode = "testMode"
    public struct Color {
        public static let backgroundDark: UIColor = UIColor.init(named: "background_dark") ?? .black
        public static let backgroundLight: UIColor = UIColor.init(named: "background_light") ?? .lightGray
        public static let textDark: UIColor = UIColor.init(named: "text_dark") ?? .black
        public static let textLight: UIColor = UIColor.init(named: "text_light") ?? .red
        public static let mapPinColor: UIColor = textLight
    }
    public struct AccessIden {
        public static let tabBarStart = "tabBarStart"

        public static let navigationBarAnimalList = "navigationBarAnimalList"
        public static let tabBarButtonAnimalList = "tabBarButtonAnimalList"
        public static let tabBarButtonOrganizations = "tabBarButtonOrganizations"

        public static let searchBarAnimalList = "searchBarAnimalList"
        public static let tableAnimalList = "tableAnimalList"
        public static let tableCellAnimalList = "tableCellAnimalList"

        public static let navigationBarOrganizations = "navigationBarOrganizations"
        public static let mapOrganizations = "mapOrganizations"
        public static let mapOrganizationsAnnotation = "mapOrganizationsAnnotation"
    }
}
