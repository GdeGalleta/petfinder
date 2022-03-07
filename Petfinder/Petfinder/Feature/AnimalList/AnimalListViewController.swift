//
//  AnimalListViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit
import Combine

public final class AnimalListViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: AnimalListViewModelType
    private let coordinator: AnimalListCoordinatorType?

    // MARK: - Initializer
    init(viewModel: AnimalListViewModelType = AnimalListViewModel(),
         coordinator: AnimalListCoordinatorType? = nil) {
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
        setupLayout()
        setupBinding()
        fetchData()
    }
}

extension AnimalListViewController {
    private func setupLayout() {
        title = "kAnimals".localized

        view.backgroundColor = .cyan

        let safeAreaLayout = view.safeAreaLayoutGuide
    }

    private func setupBinding() {

    }

    private func fetchData() {

    }
}
