//
//  OrganizationsViewModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public protocol OrganizationsViewModelType {

}

public final class OrganizationsViewModel: OrganizationsViewModelType {

    private var cancellables = Set<AnyCancellable>()

    private let apiProvider: ApiProviderType

    init(apiProvider: ApiProviderType = PetfinderApiProvider()) {
        self.apiProvider = apiProvider
    }
}
