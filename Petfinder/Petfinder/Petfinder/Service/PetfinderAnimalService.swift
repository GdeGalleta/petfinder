//
//  PetfinderAnimalService.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 16/3/22.
//

import Foundation
import Combine

public protocol PetfinderAnimalServiceType {
    func fetchTypes() -> AnyPublisher<[String], ApiError>
    func fetchAnimals(query: AnimalsQuery) -> AnyPublisher<([AnimalListModel], Bool), ApiError>
}

public final class PetfinderAnimalService: PetfinderAnimalServiceType {

    private let apiProvider: ApiProviderType

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }

    public func fetchTypes() -> AnyPublisher<[String], ApiError> {
        let resource = PetfinderApiResource<PetfinderTypesDto>.types()

        return apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderTypesDto) -> [String] in
                let factory = AnimalTypeFactory()
                return factory.decode(dto: response)
            })
            .eraseToAnyPublisher()
    }

    public func fetchAnimals(query: AnimalsQuery) -> AnyPublisher<([AnimalListModel], Bool), ApiError> {
        let resource = PetfinderApiResource<PetfinderAnimalsDto>.animals(query: query)

        return apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderAnimalsDto) -> ([AnimalListModel], Bool)? in
                // Checking if next page exists
                let hasMoreData = query.page + 1 <= response.pagination?.totalPages ?? 0

                let factory = AnimalListModelFactory()
                return (factory.decode(dto: response), hasMoreData)
            })
            .eraseToAnyPublisher()
    }
}
