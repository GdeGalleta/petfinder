//
//  OrganizationsCoordinator.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public protocol OrganizationsCoordinatorType: AnyObject {

}

public final class OrganizationsCoordinator: FlowCoordinator, OrganizationsCoordinatorType {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start(animated: Bool = true) {
        let startViewController = OrganizationsViewController(coordinator: self)
        navigationController.pushViewController(startViewController, animated: animated)
    }

    // MARK: - Flow Methods
}
