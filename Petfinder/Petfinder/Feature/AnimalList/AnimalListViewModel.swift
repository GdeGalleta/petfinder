//
//  AnimalListViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol AnimalListViewModelType {

    var dataSource: [AnimalListModel] { get }
    var dataSourcePublished: Published<[AnimalListModel]> { get }
    var dataSourcePublisher: Published<[AnimalListModel]>.Publisher { get }
    func fetchAnimals(name: String?)
    func fetchAnimals()
    func fetchMoreAnimals()
}

public final class AnimalListViewModel: AnimalListViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let apiProvider: ApiProviderType

    @Published public var dataSource: [AnimalListModel] = []
    public var dataSourcePublished: Published<[AnimalListModel]> { _dataSource }
    public var dataSourcePublisher: Published<[AnimalListModel]>.Publisher { $dataSource }

    private var query: AnimalsQuery = {
        var query = AnimalsQuery()
        query.location = "\(K.defaultLocation.latitude),\(K.defaultLocation.longitude)"
        query.distance = 60
        query.sort = "distance"
        query.page = 1
        query.limit = 20
        return query
    }()

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }

    private func fetchAnimals(query: AnimalsQuery) {
        let resource = PetfinderApiResource<PetfinderAnimalsDto>.animals(query: query)
        apiProvider
            .fetch(resource: resource)
            .compactMap({ (response: PetfinderAnimalsDto) -> [AnimalListModel] in

                //AnimalListModel to AnimalListModel
                var converted: [AnimalListModel] = []
                if let results = response.animals {
                    converted+=results.compactMap({
                        if let identifier = $0.identifier,
                           let name = $0.name {
                            var photo: AnimalListPhotoModel?
                            if let photoUrl = $0.photos?.first?.large {
                                photo = AnimalListPhotoModel(url: URL(string: photoUrl))
                            }
                            return AnimalListModel(identifier: identifier,
                                                   name: name,
                                                   age: $0.age,
                                                   gender: $0.gender,
                                                   size: $0.animalSize,
                                                   type: $0.animalType,
                                                   distance: $0.distance,
                                                   photo: photo)
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
                var dataSourceValue = self.dataSource
                dataSourceValue.append(contentsOf: response)
                dataSourceValue.removeDuplicates()
                self.dataSource = dataSourceValue
            }
            .store(in: &cancellables)
    }

    public func fetchAnimals(name: String?) {
        dataSource = []
        query.page = 1

        if let nameValue = name, !nameValue.isEmpty {
            query.name = nameValue
        } else {
            query.name = nil
        }

        fetchAnimals(query: query)
    }

    public func fetchAnimals() {
        dataSource = []
        query.page = 1
        query.name = nil
        fetchAnimals(query: query)
    }

    public func fetchMoreAnimals() {
        query.page+=1
        fetchAnimals(query: query)
    }
}
