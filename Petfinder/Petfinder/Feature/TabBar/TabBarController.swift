//
//  TabBarController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public final class TabBarController: UITabBarController {

    // MARK: - Properties
    private let coordinator: TabBarCoordinatorType?

    // MARK: - Initializer
    init(coordinator: TabBarCoordinatorType? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = K.Color.backgroundDark
        self.tabBar.tintColor = K.Color.textLight

        self.tabBar.layer.shadowColor = K.Color.backgroundDark.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
}
