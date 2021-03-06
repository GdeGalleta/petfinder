//
//  AnimalListViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol AnimalListViewModelType: ViewModelErrorReportable {

    var animalTypes: [String] { get }
    var animalTypesPublished: Published<[String]> { get }
    var animalTypesPublisher: Published<[String]>.Publisher { get }

    var dataSource: [AnimalListModel] { get }
    var dataSourcePublished: Published<[AnimalListModel]> { get }
    var dataSourcePublisher: Published<[AnimalListModel]>.Publisher { get }
    var hasDataSourceMoreData: Bool { get }

    func fetchTypes()

    func fetchAnimals(name: String?)
    func fetchAnimals(type: String?)

    func fetchAnimals()
    func fetchMoreAnimals()
}

public final class AnimalListViewModel: ViewModelErrorReporter, AnimalListViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let petfinderAnimalService: PetfinderAnimalServiceType

    @Published public var animalTypes: [String] = []
    public var animalTypesPublished: Published<[String]> { _animalTypes }
    public var animalTypesPublisher: Published<[String]>.Publisher { $animalTypes }

    @Published public var dataSource: [AnimalListModel] = []
    public var dataSourcePublished: Published<[AnimalListModel]> { _dataSource }
    public var dataSourcePublisher: Published<[AnimalListModel]>.Publisher { $dataSource }

    public var hasDataSourceMoreData: Bool = false

    private var query: AnimalsQuery = {
        var query = AnimalsQuery()
        query.location = "\(K.defaultLocation.latitude),\(K.defaultLocation.longitude)"
        query.distance = K.defaultDistance
        query.sort = "distance"
        query.page = 1
        query.limit = 20
        return query
    }()

    init(petfinderAnimalService: PetfinderAnimalServiceType = PetfinderAnimalService()) {
        self.petfinderAnimalService = petfinderAnimalService
    }

    public func fetchTypes() {
        petfinderAnimalService.fetchTypes()
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
                self.animalTypes = response
            }
            .store(in: &cancellables)
    }

    private func fetchAnimals(query: AnimalsQuery) {
        petfinderAnimalService.fetchAnimals(query: query)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.errorDescription
                    self.dataSource = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response, hasMoreData in
                guard let self = self else { return }
                self.hasDataSourceMoreData = hasMoreData

                var dataSourceValue = self.dataSource
                dataSourceValue.append(contentsOf: response)
                dataSourceValue.removeDuplicates()
                self.dataSource = dataSourceValue

                if self.dataSource.isEmpty {
                    self.errorMessage = "kNoResults".localized
                }
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

    public func fetchAnimals(type: String?) {
        dataSource = []
        query.page = 1

        if let typeValue = type, !typeValue.isEmpty {
            query.type = typeValue
        } else {
            query.type = nil
        }

        fetchAnimals(query: query)
    }

    public func fetchAnimals() {
        dataSource = []
        query.page = 1
        query.type = nil
        query.name = nil
        fetchAnimals(query: query)
    }

    public func fetchMoreAnimals() {
        query.page+=1
        fetchAnimals(query: query)
    }
}
