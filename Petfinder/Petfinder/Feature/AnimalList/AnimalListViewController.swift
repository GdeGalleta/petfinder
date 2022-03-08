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

    private enum Section: CaseIterable { case animals }
    private typealias DataSource = UITableViewDiffableDataSource<Section, AnimalListModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnimalListModel>
    private var dataSource: DataSource!

    private let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .black
        return control
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        table.register(AnimalListCell.self, forCellReuseIdentifier: AnimalListCell.identifier)
        table.accessibilityIdentifier = "default"
        return table
    }()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "kSearchByName".localized
        controller.searchBar.barStyle = .black
        controller.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        controller.searchBar.delegate = self
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()

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
        setupDataSource()
        setupBinding()
        fetchData()
    }
}

extension AnimalListViewController {
    private func setupLayout() {
        title = "kAnimals".localized

        view.backgroundColor = .white

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        refreshControl.attributedTitle = NSAttributedString(string: "kRefreshing")
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)

        view.addSubview(tableView)
        tableView.addSubview(refreshControl)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupBinding() {
        viewModel.dataSourcePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.setupSnapshot()
                self.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
    }

    @objc private func fetchData() {
        viewModel.fetchAnimals()
    }
}

extension AnimalListViewController {

    private func setupDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListCell.identifier, for: indexPath) as? AnimalListCell
                cell?.setup(with: model)
                cell?.accessibilityIdentifier = "default"
                return cell
            })
    }

    private func setupSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.animals])
        snapshot.appendItems(viewModel.dataSource)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AnimalListViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Coordinate to detail
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // guard !UIApplication.isRunningTest else { return }
        if indexPath.row == viewModel.dataSource.count-1 {
            viewModel.fetchMoreAnimals()
        }
    }
}

extension AnimalListViewController: UISearchBarDelegate {

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchAnimals()
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(self.reload(_:)),
                                               object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.fetchAnimals(name: searchBar.text)
    }
}
