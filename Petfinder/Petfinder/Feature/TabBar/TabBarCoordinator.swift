//
//  TabBarCoordinator.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public protocol TabBarCoordinatorType: AnyObject {

}

public final class TabBarCoordinator: FlowCoordinator, TabBarCoordinatorType {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start(animated: Bool) {
        let tabBarController = TabBarController(coordinator: self)
        tabBarController.tabBar.accessibilityIdentifier = K.AccessIden.tabBarStart

        // AnimalList
        let animalListTabBarItem = UITabBarItem(title: "kAnimals".localized,
                                                image: UIImage(systemName: "tortoise.fill"),
                                                tag: 0)
        animalListTabBarItem.accessibilityIdentifier = K.AccessIden.tabBarButtonAnimalList
        let animalListNavigationController = UINavigationController()
        animalListNavigationController.tabBarItem = animalListTabBarItem
        let animalListCoordinator = AnimalListCoordinator(navigationController: animalListNavigationController)

        // Organizations
        let organizationTabBarItem = UITabBarItem(title: "kOrganizations".localized,
                                                  image: UIImage(systemName: "star.fill"),
                                                  tag: 1)
        organizationTabBarItem.accessibilityIdentifier = K.AccessIden.tabBarButtonOrganizations
        let organizationsNavigationController = UINavigationController()
        organizationsNavigationController.tabBarItem = organizationTabBarItem
        let organizationsCoordinator = OrganizationsCoordinator(navigationController: organizationsNavigationController)

        tabBarController.viewControllers = [animalListNavigationController, organizationsNavigationController]

        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false, completion: { [weak self] in
            self?.coordinate(to: animalListCoordinator, animated: false)
            self?.coordinate(to: organizationsCoordinator, animated: false)
        })
    }
}
