//
//  OrganizationModelFactory.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import Foundation

public struct OrganizationModelFactory: GenericDecoderFactory {

    public func decode(dto: PetfinderOrganizationsDto) -> [OrganizationModel] {
        var converted: [OrganizationModel] = []
        if let results = dto.organizations {
            converted+=results.compactMap({
                if let identifier = $0.identifier,
                   let name = $0.name,
                   let email = $0.email,
                   let country = $0.address?.country, !country.isEmpty,
                   let postcode = $0.address?.postcode, !postcode.isEmpty,
                   let state = $0.address?.state, !state.isEmpty,
                   let city = $0.address?.city, !city.isEmpty,
                   let address = $0.address?.address1 ?? $0.address?.address2, !address.isEmpty {
                    let completeAddress = "\(address) \(city) \(state) \(postcode) \(country)"
                    return OrganizationModel(identifier: identifier,
                                             name: name,
                                             email: email,
                                             address: completeAddress)
                }
                return nil
            })
        }
        return converted
    }
}
