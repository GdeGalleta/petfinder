//
//  OrganizationsViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit
import MapKit
import CoreLocation
import Combine

public final class OrganizationsViewController: UIViewController {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: OrganizationsViewModelType
    private let coordinator: OrganizationsCoordinatorType?

    private let coordScale = 10000.0
    private lazy var coordRegion = MKCoordinateRegion(center: K.defaultLocation, latitudinalMeters: coordScale, longitudinalMeters: coordScale)
    private lazy var viewMap: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.setRegion(self.coordRegion, animated: false)
        map.delegate = self
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

        view.backgroundColor = .white

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
        viewModel.dataSourcePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] organizations in
                guard let self = self else { return }
                guard !organizations.isEmpty else { return }
                self.setupLocations(organizations: organizations)
            }
            .store(in: &cancellables)
    }

    private func fetchData() {
        viewModel.fetchOrganizations()
    }

    private func setupLocations(organizations: [OrganizationModel]) {

        for organization in organizations {
            let address = organization.address

            print(address)
            
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }

                let coder = CLGeocoder()
                coder.geocodeAddressString(address,
                                              completionHandler: { [weak self] (placemarks, error) -> Void in
                    guard let self = self else { return }
                    guard error == nil else {
                        print("Error: \(error!) \n Address: \(address)")
                        return
                    }

                    guard let placemark = placemarks?.first else { return }

                    if let coordinates = placemark.location?.coordinate {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinates
                        annotation.title = organization.name
                        annotation.subtitle = organization.email

                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.viewMap.addAnnotation(annotation)
                        }
                    }
                })
            }
        }
    }
}

extension OrganizationsViewController: MKMapViewDelegate {

    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "OrganizationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
