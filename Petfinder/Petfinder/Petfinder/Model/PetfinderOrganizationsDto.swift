//
//  PetfinderOrganizationsDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import Foundation

// MARK: - OrganizationsDto
public struct PetfinderOrganizationsDto: Codable {
    let organizations: [PetfinderOrganizationDto]?
    let pagination: Pagination?
}

// MARK: - Organization
public struct PetfinderOrganizationDto: Codable {
    let identifier, name: String?
    let email, phone: String?
    let address: Address?
    let hours: PetfinderHoursDto?
    let url: String?
    let website: String?
    let missionStatement: String?
    let adoption: PetfinderAdoptionDto?
    let socialMedia: PetfinderSocialMediaDto?
    let photos: [Photo]?
    let distance: Double?
    let links: PetfinderOrganizationLinksDto?

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
public struct PetfinderAddressDto: Codable {
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
}

// MARK: - Adoption
public struct PetfinderAdoptionDto: Codable {
    let policy: String?
    let url: String?
}

// MARK: - Hours
public struct PetfinderHoursDto: Codable {
    let monday, tuesday, wednesday, thursday: String?
    let friday, saturday, sunday: String?
}

// MARK: - OrganizationLinks
public struct PetfinderOrganizationLinksDto: Codable {
    let linksSelf, animals: PetfinderNextDto?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case animals
    }
}

// MARK: - Next
public struct PetfinderNextDto: Codable {
    let href: String?
}

// MARK: - Photo
public struct PetfinderPhotoDto: Codable {
    let small, medium, large, full: String?
}

// MARK: - SocialMedia
struct PetfinderSocialMediaDto: Codable {
    let facebook: String?
    let twitter: String?
    let youtube: String?
    let instagram: String?
    let pinterest: String?
}

// MARK: - Pagination
public struct PetfinderPaginationDto: Codable {
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
public struct PetfinderPaginationLinksDto: Codable {
    let next: PetfinderNextDto?
}
