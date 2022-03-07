//
//  PetfinderApiProviderMock.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

public final class PetfinderApiProviderMock: PetfinderApiProvider {

    public override func fetchToken() -> AnyPublisher<PetfinderOAuthDto, ApiError> {        
        let data = PetfinderOAuthDto(tokenType: "tokenType", expiresIn: 3600, accessToken: "accessToken")
        return Just(data)
            .setFailureType(to: ApiError.self)
            .eraseToAnyPublisher()
    }
}
