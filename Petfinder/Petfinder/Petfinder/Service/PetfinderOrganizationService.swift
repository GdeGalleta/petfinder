//
//  PetfinderOrganizationService.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 16/3/22.
//

import Foundation
import Combine

public protocol PetfinderOrganizationServiceType {
    func fetchOrganizations(query: OrganizationsQuery) -> AnyPublisher<([OrganizationModel], Bool), ApiError>
}

public final class PetfinderOrganizationService: PetfinderOrganizationServiceType {

    private let apiProvider: ApiProviderType

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }

    public func fetchOrganizations(query: OrganizationsQuery) -> AnyPublisher<([OrganizationModel], Bool), ApiError> {
        let resource = PetfinderApiResource<PetfinderOrganizationsDto>.organizations(query: query)

        return apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderOrganizationsDto) -> ([OrganizationModel], Bool)? in
                // Checking if next page exists
                let hasMoreData = query.page + 1 <= response.pagination?.totalPages ?? 0

                let factory = OrganizationModelFactory()
                return (factory.decode(dto: response), hasMoreData)
            })
            .eraseToAnyPublisher()
    }
}
