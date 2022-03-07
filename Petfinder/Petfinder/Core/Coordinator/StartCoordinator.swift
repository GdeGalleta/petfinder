//
//  StartCoordinator.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public final class StartCoordinator: FlowCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start(animated: Bool = true) {
        let startCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator, animated: animated)
    }
}
