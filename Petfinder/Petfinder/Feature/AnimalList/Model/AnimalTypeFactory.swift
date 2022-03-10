//
//  AnimalTypeFactory.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import Foundation

public struct AnimalTypeFactory: GenericDecoderFactory {

    public func decode(dto: PetfinderTypesDto) -> [String] {
        var converted: [String] = ["kAll".localized]
        if let results = dto.types?.prefix(3) {
            converted+=results.compactMap({
                if let name = $0.name, !name.isEmpty { return name }
                return nil
            })
        }
        return converted
    }
}
