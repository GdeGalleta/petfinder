//
//  OrganizationsViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit
import MapKit
import Combine

public final class OrganizationsViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: OrganizationsViewModelType
    private let coordinator: OrganizationsCoordinatorType?

    private let coordScale = 20000.0
    private lazy var coordRegion = MKCoordinateRegion(center: K.defaultLocation, latitudinalMeters: coordScale, longitudinalMeters: coordScale)
    private lazy var viewMap: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.setRegion(self.coordRegion, animated: false)
        return map
    }()

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
        setupLayout()
        setupBinding()
        fetchData()
    }
}

extension OrganizationsViewController {
    private func setupLayout() {
        title = "kOrganizations".localized

        view.backgroundColor = .cyan

        view.addSubview(viewMap)

        let safeAreaLayout = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            viewMap.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor),
            viewMap.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewMap.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor),
            viewMap.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor)
        ])
    }

    private func setupBinding() {

    }

    private func fetchData() {

    }
}
