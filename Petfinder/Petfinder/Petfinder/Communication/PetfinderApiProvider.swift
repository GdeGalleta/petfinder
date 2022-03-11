//
//  PetfinderApiProvider.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

private struct PetfinderApiProviderTokenCache {
    static var token: PetfinderOAuthDto?
    static var timestamp: Double?
}

public class PetfinderApiProvider {

    private var cancellables: Set<AnyCancellable> = []

    private let apiProvider: ApiProviderType

    public init(apiProvider: ApiProviderType = ApiProvider()) {
        self.apiProvider = apiProvider
    }

    public func fetchToken() -> AnyPublisher<PetfinderOAuthDto, ApiError> {
        // Get token from cache
        if let token = PetfinderApiProviderTokenCache.token,
           let timestamp = PetfinderApiProviderTokenCache.timestamp,
           timestamp > Date().timeIntervalSince1970 {
            return Just(token)
                .setFailureType(to: ApiError.self)
                .eraseToAnyPublisher()
        }

        // Get token from API
        let resource = PetfinderApiResource<PetfinderOAuthDto>.token()
        return apiProvider.fetch(resource: resource)
            .map { (response: PetfinderOAuthDto) -> AnyPublisher<PetfinderOAuthDto, ApiError> in
                guard let expiresIn = response.expiresIn else {
                    return Fail(error: ApiError.apiError(description: "Invalid expiration time")).eraseToAnyPublisher()
                }

                let timestamp = Date().timeIntervalSince1970
                PetfinderApiProviderTokenCache.token = response
                PetfinderApiProviderTokenCache.timestamp = timestamp + expiresIn * 0.95
                return Just(response).setFailureType(to: ApiError.self).eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension PetfinderApiProvider: ApiProviderType {

    public func fetchData<V>(resource: V) -> AnyPublisher<Data, ApiError> where V: ApiResourceType {
        return fetchToken()
            .map { [weak self] response -> AnyPublisher<Data, ApiError> in
                guard let self = self else {
                    return Fail(error: ApiError.unknown).eraseToAnyPublisher()
                }
                guard let token = response.accessToken else {
                    return Fail(error: ApiError.apiError(description: "Invalid token")).eraseToAnyPublisher()
                }
                resource.headers = ["Authorization": "Bearer \(token)"]
                return self.apiProvider.fetchData(resource: resource)
            }
            .switchToLatest()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public func fetch<T, V>(resource: V) -> AnyPublisher<T, ApiError> where T: Decodable, V: ApiResourceType {
        return fetchToken()
            .map { [weak self] response -> AnyPublisher<T, ApiError> in
                guard let self = self else {
                    return Fail(error: ApiError.unknown).eraseToAnyPublisher()
                }
                guard let token = response.accessToken else {
                    return Fail(error: ApiError.apiError(description: "Invalid token")).eraseToAnyPublisher()
                }
                resource.headers = ["Authorization": "Bearer \(token)"]
                return self.apiProvider.fetch(resource: resource)
            }
            .switchToLatest()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
