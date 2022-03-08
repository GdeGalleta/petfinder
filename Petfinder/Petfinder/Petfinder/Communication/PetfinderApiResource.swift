//
//  PetfinderApiResource.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation
import Combine

private enum PetfinderEndpoint: String {
    case undefined
    case token = "oauth2/token"
    case animals
    case organizations
}

public final class PetfinderApiResource<T: Decodable>: ApiResource<T> {

    private convenience init(httpMethod: ApiHttpMethod,
                             endpoint: PetfinderEndpoint,
                             queryParameters: [String: Any] = [:],
                             headers: [String: String] = [:]) {
        self.init(httpMethod: httpMethod,
                  baseURL: "https://api.petfinder.com/v2/",
                  pathURL: endpoint.rawValue,
                  queryParameters: queryParameters,
                  headers: ["Content-Type": "application/json"])
    }

    // MARK: - Actions
    public class func token() -> PetfinderApiResource<PetfinderOAuthDto> {
        let queryParameters = ["grant_type": "client_credentials",
                               "client_id": ApiKeys.apikey,
                               "client_secret": ApiKeys.secret]
        let resource = PetfinderApiResource<PetfinderOAuthDto>(
            httpMethod: .POST,
            endpoint: .token,
            queryParameters: queryParameters)
        return resource
    }

    public class func animals(query: AnimalsQuery? = nil) -> PetfinderApiResource<PetfinderAnimalsDto> {
        let queryParameters = query?.dictionary ?? [:]
        let resource = PetfinderApiResource<PetfinderAnimalsDto>(
            httpMethod: .GET,
            endpoint: .animals,
            queryParameters: queryParameters)
        return resource
    }

    public class func organizations(query: OrganizationsQuery? = nil) -> PetfinderApiResource<PetfinderOrganizationsDto> {
        let queryParameters = query?.dictionary ?? [:]
        let resource = PetfinderApiResource<PetfinderOrganizationsDto>(
            httpMethod: .GET,
            endpoint: .organizations,
            queryParameters: queryParameters)
        return resource
    }
}
