//
//  AnimalListViewController.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit
import Combine

public final class AnimalListViewController: PetfinderViewController {

    // MARK: - Properties
    public var cancellables = Set<AnyCancellable>()
    public var viewModel: AnimalListViewModelType

    private let coordinator: AnimalListCoordinatorType?

    private enum Section: CaseIterable { case animals }
    private typealias DataSource = UITableViewDiffableDataSource<Section, AnimalListModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnimalListModel>
    private var dataSource: DataSource!

    private let refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = K.Color.textLight
        control.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return control
    }()

    private let footerSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = K.Color.textLight
        return spinner
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        table.register(AnimalListCell.self, forCellReuseIdentifier: AnimalListCell.identifier)
        table.accessibilityIdentifier = K.AccessIden.tableAnimalList
        table.tableFooterView = footerSpinner
        return table
    }()

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "kSearchByName".localized
        controller.searchBar.barStyle = .black
        controller.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        controller.searchBar.tintColor = K.Color.textLight
        controller.searchBar.delegate = self
        controller.searchBar.accessibilityIdentifier = K.AccessIden.searchBarAnimalList
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
        navigationController?.navigationBar.accessibilityIdentifier = K.AccessIden.navigationBarAnimalList
        navigationItem.title = "kAnimalListTitle".localized

        view.backgroundColor = K.Color.backgroundDark

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

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
        viewModel.animalTypesPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                guard let self = self else { return }
                self.searchController.searchBar.scopeButtonTitles = response
                self.searchController.searchBar.selectedScopeButtonIndex = 0
            }
            .store(in: &cancellables)

        viewModel.dataSourcePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.setupSnapshot()
                self.refreshControl.endRefreshing()
                self.footerSpinner.stopAnimating()
            }
            .store(in: &cancellables)
    }

    @objc private func fetchData() {
        viewModel.fetchTypes()
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
                cell?.cellColor = UIColor.colorForIndex(indexPath.row, overR: true)
                cell?.accessibilityIdentifier = K.AccessIden.tableCellAnimalList
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

extension AnimalListViewController: ViewControllerErrorReportable {

    public var baseViewModel: ViewModelErrorReportable {
        get { return self.viewModel }
    }
}

extension AnimalListViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !UIApplication.isRunningTest else { return }
        guard viewModel.hasDataSourceMoreData else { return }

        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1

        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            footerSpinner.startAnimating()
            viewModel.fetchMoreAnimals()
        }
    }
}

extension AnimalListViewController: UISearchBarDelegate {

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        var selectedType: String? = viewModel.animalTypes[selectedScope]
        selectedType = "kAll".localized != selectedType ? selectedType : nil
        viewModel.fetchAnimals(type: selectedType)

        searchController.searchBar.endEditing(true)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchData()
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(self.reload(_:)),
                                               object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 1)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.fetchAnimals(name: searchBar.text)
    }
}
