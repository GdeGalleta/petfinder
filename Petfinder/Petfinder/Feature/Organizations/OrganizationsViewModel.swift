//
//  OrganizationsViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol OrganizationsViewModelType {
    var dataSource: [OrganizationModel] { get }
    var dataSourcePublished: Published<[OrganizationModel]> { get }
    var dataSourcePublisher: Published<[OrganizationModel]>.Publisher { get }
    func fetchOrganizations()
}

public final class OrganizationsViewModel: OrganizationsViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let apiProvider: ApiProviderType

    @Published public var dataSource: [OrganizationModel] = []
    public var dataSourcePublished: Published<[OrganizationModel]> { _dataSource }
    public var dataSourcePublisher: Published<[OrganizationModel]>.Publisher { $dataSource }

    private var query: OrganizationsQuery = {
        var query = OrganizationsQuery()
        query.location = "\(K.defaultLocation.latitude),\(K.defaultLocation.longitude)"
        query.distance = 60
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
        apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderOrganizationsDto) -> [OrganizationModel] in
                var converted: [OrganizationModel] = []
                if let results = response.organizations {
                    converted+=results.compactMap({
                        if let identifier = $0.identifier,
                           let name = $0.name,
                           let email = $0.email,
                           let address1 = $0.address?.address1, !address1.isEmpty,
                           let address2 = $0.address?.address2, !address2.isEmpty,
                           let country = $0.address?.country, !country.isEmpty,
                           let postcode = $0.address?.postcode, !postcode.isEmpty,
                           let state = $0.address?.state, !state.isEmpty,
                           let city = $0.address?.city, !city.isEmpty {

                            var address = ""
                            address+=" \(address1)"
                            // address+=" \(address2)"
                            address+=" \(city)"
                            address+=" \(state)"
                            address+=" \(postcode)"
                            address+=" \(country)"
                            // address+=" United States"

                            return OrganizationModel(identifier: identifier,
                                                     name: name,
                                                     email: email,
                                                     address: address)
                        }
                        return nil
                    })
                }
                return converted
            })
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                    case .failure:
                        self.dataSource = []
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.dataSource+=response
            }
            .store(in: &cancellables)
    }

    public func fetchOrganizations() {
        fetchOrganizations(query: query)
    }
}
