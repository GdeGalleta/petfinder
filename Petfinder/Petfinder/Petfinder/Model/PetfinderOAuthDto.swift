//
//  PetfinderOAuthDto.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

public struct PetfinderOAuthDto: Codable {
    let tokenType: String?
    let expiresIn: Int?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
    }
}
