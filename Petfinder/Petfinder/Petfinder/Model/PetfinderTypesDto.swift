//
//  PetfinderTypesDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 9/3/22.
//

import Foundation

// MARK: - PetfinderTypesDto
public struct PetfinderTypesDto: Codable {
    let types: [PetfinderTypesTypeElementDto]?
}

// MARK: - TypeElement
public struct PetfinderTypesTypeElementDto: Codable {
    let name: String?
}
