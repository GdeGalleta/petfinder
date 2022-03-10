//
//  AnimalListModelFactory.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import Foundation

public struct AnimalListModelFactory: GenericDecoderFactory {

    public func decode(dto: PetfinderAnimalsDto) -> [AnimalListModel] {
        var converted: [AnimalListModel] = []
        if let results = dto.animals {
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
    }
}
