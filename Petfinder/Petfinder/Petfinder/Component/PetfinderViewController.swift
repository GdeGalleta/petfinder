//
//  PetfinderViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import UIKit

public class PetfinderViewController: UIViewController {

    // MARK: - Properties
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = K.Color.backgroundDark
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0), .foregroundColor: K.Color.textLight]

        navigationController?.navigationBar.tintColor = K.Color.textLight
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        if let alertTypeViewController = self as? ViewControllerErrorReportable {
            alertTypeViewController.bindAlert()
        }
    }
}
