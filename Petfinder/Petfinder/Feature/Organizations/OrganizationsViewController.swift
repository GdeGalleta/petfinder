//
//  OrganizationsViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit
import Combine

public final class OrganizationsViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: OrganizationsViewModelType
    private let coordinator: OrganizationsCoordinatorType?

    // MARK: - Initializer
    init(viewModel: OrganizationsViewModelType = OrganizationsViewModel(),
         coordinator: OrganizationsCoordinatorType? = nil) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}
