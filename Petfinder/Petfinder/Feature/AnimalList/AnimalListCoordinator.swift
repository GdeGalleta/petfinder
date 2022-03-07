//
//  AnimalListCoordinator.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public protocol AnimalListCoordinatorType: AnyObject {

}

public final class AnimalListCoordinator: FlowCoordinator, AnimalListCoordinatorType {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start(animated: Bool = true) {
        let startViewController = AnimalListViewController(coordinator: self)
        navigationController.pushViewController(startViewController, animated: animated)
    }

    // MARK: - Flow Methods
}
