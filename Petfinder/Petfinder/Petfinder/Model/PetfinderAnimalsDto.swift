//
//  PetfinderAnimalsDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

// MARK: - AnimalsDto
public struct PetfinderAnimalsDto: Codable {
    let animals: [PetfinderAnimalsAnimalDto]?
    let pagination: PetfinderAnimalsPaginationDto?
}

// MARK: - Animal
public struct PetfinderAnimalsAnimalDto: Codable {
    let identifier: Int?
    let organizationID: String?
    let url: String?
    let animalType, species: String?
    let breeds: PetfinderAnimalsBreedsDto?
    let colors: PetfinderAnimalsColorsDto?
    let age, gender, animalSize, coat: String?
    let name, animalDescription: String?
    let photos: [PetfinderAnimalsPhotoDto]?
    let videos: [PetfinderAnimalsVideoDto]?
    let status: String?
    let attributes: PetfinderAttributesDto?
    let environment: PetfinderAnimalsEnvironmentDto?
    let tags: [String]?
    let contact: PetfinderAnimalsContactDto?
    let publishedAt: String?
    let distance: Double?
    let links: PetfinderAnimalsAnimalLinksDto?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case organizationID = "organization_id"
        case url, species, breeds, colors, age, gender, coat, name
        case animalSize = "size"
        case animalType = "type"
        case animalDescription = "description"
        case photos, videos, status, attributes, environment, tags, contact
        case publishedAt = "published_at"
        case distance
        case links = "_links"
    }
}

// MARK: - Attributes
public struct PetfinderAttributesDto: Codable {
    let spayedNeutered, houseTrained, declawed, specialNeeds: Bool?
    let shotsCurrent: Bool?

    enum CodingKeys: String, CodingKey {
        case spayedNeutered = "spayed_neutered"
        case houseTrained = "house_trained"
        case declawed
        case specialNeeds = "special_needs"
        case shotsCurrent = "shots_current"
    }
}

// MARK: - Breeds
public struct PetfinderAnimalsBreedsDto: Codable {
    let primary: String?
    let mixed, unknown: Bool?
}

// MARK: - Colors
public struct PetfinderAnimalsColorsDto: Codable {
    let primary: String?
}

// MARK: - Contact
public struct PetfinderAnimalsContactDto: Codable {
    let email, phone: String?
    let address: PetfinderAnimalsAddressDto?
}

// MARK: - Address
public struct PetfinderAnimalsAddressDto: Codable {
    let address1, address2: String?
    let city, state, postcode, country: String?
}

// MARK: - Environment
public struct PetfinderAnimalsEnvironmentDto: Codable {
    let children, dogs, cats: Bool?
}

// MARK: - AnimalLinks
public struct PetfinderAnimalsAnimalLinksDto: Codable {
    let linksSelf, type, organization: PetfinderAnimalsOrganizationDto?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case type, organization
    }
}

// MARK: - Organization
public struct PetfinderAnimalsOrganizationDto: Codable {
    let href: String?
}

// MARK: - Photo
public struct PetfinderAnimalsPhotoDto: Codable {
    let small, medium, large, full: String?
}

// MARK: - Video
public struct PetfinderAnimalsVideoDto: Codable {
    let embed: String?
}

// MARK: - Pagination
public struct PetfinderAnimalsPaginationDto: Codable {
    let countPerPage, totalCount, currentPage, totalPages: Int?
    let links: PetfinderAnimalsPaginationLinksDto?

    enum CodingKeys: String, CodingKey {
        case countPerPage = "count_per_page"
        case totalCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links = "_links"
    }
}

// MARK: - PaginationLinks
public struct PetfinderAnimalsPaginationLinksDto: Codable {
}
