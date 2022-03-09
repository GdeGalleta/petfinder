//
//  PetfinderOrganizationsDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import Foundation

// MARK: - OrganizationsDto
public struct PetfinderOrganizationsDto: Codable {
    let organizations: [PetfinderOrganizationsOrganizationDto]?
    let pagination: PetfinderOrganizationsPaginationDto?
}

// MARK: - Organization
public struct PetfinderOrganizationsOrganizationDto: Codable {
    let identifier, name: String?
    let email, phone: String?
    let address: PetfinderOrganizationsAddressDto?
    let hours: PetfinderOrganizationsHoursDto?
    let url: String?
    let website: String?
    let missionStatement: String?
    let adoption: PetfinderOrganizationsAdoptionDto?
    let socialMedia: PetfinderOrganizationsSocialMediaDto?
    let photos: [PetfinderOrganizationsPhotoDto]?
    let distance: Double?
    let links: PetfinderOrganizationsOrganizationLinksDto?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name, email, phone, address, hours, url, website
        case missionStatement = "mission_statement"
        case adoption
        case socialMedia = "social_media"
        case photos, distance
        case links = "_links"
    }
}

// MARK: - Address
public struct PetfinderOrganizationsAddressDto: Codable {
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
}

// MARK: - Adoption
public struct PetfinderOrganizationsAdoptionDto: Codable {
    let policy: String?
    let url: String?
}

// MARK: - Hours
public struct PetfinderOrganizationsHoursDto: Codable {
    let monday, tuesday, wednesday, thursday: String?
    let friday, saturday, sunday: String?
}

// MARK: - OrganizationLinks
public struct PetfinderOrganizationsOrganizationLinksDto: Codable {
    let linksSelf, animals: PetfinderOrganizationsNextDto?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case animals
    }
}

// MARK: - Next
public struct PetfinderOrganizationsNextDto: Codable {
    let href: String?
}

// MARK: - Photo
public struct PetfinderOrganizationsPhotoDto: Codable {
    let small, medium, large, full: String?
}

// MARK: - SocialMedia
struct PetfinderOrganizationsSocialMediaDto: Codable {
    let facebook: String?
    let twitter: String?
    let youtube: String?
    let instagram: String?
    let pinterest: String?
}

// MARK: - Pagination
public struct PetfinderOrganizationsPaginationDto: Codable {
    let countPerPage, totalCount, currentPage, totalPages: Int?
    let links: PetfinderOrganizationsPaginationLinksDto?

    enum CodingKeys: String, CodingKey {
        case countPerPage = "count_per_page"
        case totalCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links = "_links"
    }
}

// MARK: - PaginationLinks
public struct PetfinderOrganizationsPaginationLinksDto: Codable {
    let next: PetfinderOrganizationsNextDto?
}
