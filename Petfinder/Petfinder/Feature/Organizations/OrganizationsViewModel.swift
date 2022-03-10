//
//  OrganizationsViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol OrganizationsViewModelType: ViewModelErrorReportable {
    var dataSource: [OrganizationModel] { get }
    var dataSourcePublished: Published<[OrganizationModel]> { get }
    var dataSourcePublisher: Published<[OrganizationModel]>.Publisher { get }

    var hasDataSourceMoreData: Bool { get }
    var hasDataSourceMoreDataPublished: Published<Bool> { get }
    var hasDataSourceMoreDataPublisher: Published<Bool>.Publisher { get }

    func fetchOrganizations()
    func fetchMoreOrganizations()
}

public final class OrganizationsViewModel: ViewModelErrorReporter, OrganizationsViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let apiProvider: ApiProviderType

    @Published public var dataSource: [OrganizationModel] = []
    public var dataSourcePublished: Published<[OrganizationModel]> { _dataSource }
    public var dataSourcePublisher: Published<[OrganizationModel]>.Publisher { $dataSource }

    @Published public var hasDataSourceMoreData: Bool = false
    public var hasDataSourceMoreDataPublished: Published<Bool> { _hasDataSourceMoreData }
    public var hasDataSourceMoreDataPublisher: Published<Bool>.Publisher { $hasDataSourceMoreData }

    private var query: OrganizationsQuery = {
        var query = OrganizationsQuery()
        query.location = "\(K.defaultLocation.latitude),\(K.defaultLocation.longitude)"
        query.distance = K.defaultDistance
        query.sort = "distance"
        query.page = 1
        query.limit = 100
        return query
    }()

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }

    private func fetchOrganizations(query: OrganizationsQuery) {
        let resource = PetfinderApiResource<PetfinderOrganizationsDto>.organizations(query: query)
        var hasMoreData = hasDataSourceMoreData
        apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderOrganizationsDto) -> [OrganizationModel] in
                // Checking if next page exists
                hasMoreData = query.page + 1 <= response.pagination?.totalPages ?? 0

                let factory = OrganizationModelFactory()
                return factory.decode(dto: response)
            })
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                    case .failure(let error):
                        self.errorMessage = error.errorDescription
                        self.dataSource = []
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.hasDataSourceMoreData = hasMoreData

                var dataSourceValue = self.dataSource
                dataSourceValue.append(contentsOf: response)
                dataSourceValue.removeDuplicates()
                self.dataSource = dataSourceValue
            }
            .store(in: &cancellables)
    }

    public func fetchOrganizations() {
        dataSource = []
        fetchOrganizations(query: query)
    }

    public func fetchMoreOrganizations() {
        query.page+=1
        fetchOrganizations(query: query)
    }
}
