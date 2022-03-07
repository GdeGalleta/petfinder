//
//  AnimalListViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol AnimalListViewModelType {

}

public final class AnimalListViewModel: AnimalListViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let apiProvider: ApiProviderType

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }
}
