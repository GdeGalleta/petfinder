//
//  PetfinderAnimalsDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

// MARK: - AnimalsDto
public struct PetfinderAnimalsDto: Codable {
    let animals: [Animal]?
    let pagination: Pagination?
}

// MARK: - Animal
public struct Animal: Codable {
    let identifier: Int?
    let organizationID: String?
    let url: String?
    let animalType, species: String?
    let breeds: Breeds?
    let colors: Colors?
    let age, gender, animalSize, coat: String?
    let name, animalDescription: String?
    let photos: [Photo]?
    let videos: [Video]?
    let status: String?
    let attributes: Attributes?
    let environment: Environment?
    let tags: [String]?
    let contact: Contact?
    let publishedAt: String?
    let distance: Double?
    let links: AnimalLinks?

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
public struct Attributes: Codable {
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
public struct Breeds: Codable {
    let primary: String?
    let mixed, unknown: Bool?
}

// MARK: - Colors
public struct Colors: Codable {
    let primary: String?
}

// MARK: - Contact
public struct Contact: Codable {
    let email, phone: String?
    let address: Address?
}

// MARK: - Address
public struct Address: Codable {
    let address1, address2: String?
    let city, state, postcode, country: String?
}

// MARK: - Environment
public struct Environment: Codable {
    let children, dogs, cats: Bool?
}

// MARK: - AnimalLinks
public struct AnimalLinks: Codable {
    let linksSelf, type, organization: Organization?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case type, organization
    }
}

// MARK: - Organization
public struct Organization: Codable {
    let href: String?
}

// MARK: - Photo
public struct Photo: Codable {
    let small, medium, large, full: String?
}

// MARK: - Video
public struct Video: Codable {
    let embed: String?
}

// MARK: - Pagination
public struct Pagination: Codable {
    let countPerPage, totalCount, currentPage, totalPages: Int?
    let links: PaginationLinks?

    enum CodingKeys: String, CodingKey {
        case countPerPage = "count_per_page"
        case totalCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links = "_links"
    }
}

// MARK: - PaginationLinks
public struct PaginationLinks: Codable {
}
