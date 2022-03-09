//
//  CoordinatorTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 9/3/22.
//

import XCTest

class CoordinatorTests: XCTestCase {

    private var window: UIWindow?
    private var navigationController: UINavigationControllerMock?
    private var startCoordinator: FlowCoordinator?
    private var tabBarCoordinator: (FlowCoordinator & TabBarCoordinatorType)?
    private var animalListCoordinator: (FlowCoordinator & AnimalListCoordinatorType)?
    private var organizationsCoordinator: (FlowCoordinator & OrganizationsCoordinatorType)?

    override func setUpWithError() throws {
        window = UIWindow()
        navigationController = UINavigationControllerMock()
        startCoordinator = MainCoordinator(window: window!)
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController!)
        animalListCoordinator = AnimalListCoordinator(navigationController: navigationController!)
        organizationsCoordinator = OrganizationsCoordinator(navigationController: navigationController!)

        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        window = nil
        navigationController = nil
        startCoordinator = nil
        tabBarCoordinator = nil
        animalListCoordinator = nil
        organizationsCoordinator = nil
    }

    func test_startApplication() {
        let expectedViewController = TabBarController()

        startCoordinator!.start(animated: false)

        if let navigationController = window!.rootViewController as? UINavigationController,
           let tabBarController = navigationController.presentedViewController as? UITabBarController {
            XCTAssert(type(of: tabBarController) == type(of: expectedViewController))
        } else {
            XCTFail("Wrong view controller")
        }
    }

    func test_startAnimalList() {
        let expectedViewController = AnimalListViewController()

        animalListCoordinator!.start(animated: false)

        if let navigationController = window!.rootViewController as? UINavigationController,
           let viewController = navigationController.viewControllers.first {
            XCTAssert(type(of: viewController) == type(of: expectedViewController))
        } else {
            XCTFail("Wrong view controller")
        }
    }

    func test_startOrganizations() {
        let expectedViewController = OrganizationsViewController()

        organizationsCoordinator!.start(animated: false)

        if let navigationController = window!.rootViewController as? UINavigationController,
           let viewController = navigationController.viewControllers.first {
            XCTAssert(type(of: viewController) == type(of: expectedViewController))
        } else {
            XCTFail("Wrong view controller")
        }
    }
}

private final class UINavigationControllerMock: UINavigationController {
    fileprivate var dismissed = false
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissed = true
        super.dismiss(animated: flag, completion: completion)
    }
}
