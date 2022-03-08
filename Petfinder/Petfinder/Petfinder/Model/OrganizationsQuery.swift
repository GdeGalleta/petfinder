//
//  OrganizationsQuery.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import Foundation

public struct OrganizationsQuery: Encodable {
    var name: String? ///Return results matching organization name
    var location: String? ///Return results by location. Values: city, state; latitude,longitude; or postal code.
    var distance: Int? ///Return results within distance of location (in miles). Values: requires location to be set (default: 100, max: 500)
    var state: String? ///Filter results by state Values: Accepts two-letter abbreviations, e.g. AL, WY
    var country: String? ///Filter results by country. Values: Accepts two-letter abbreviations, e.g. US, CA
    var query: String? ///Search on name, city, state (Search that includes synonyms, varying punctuation, etc.)
    var sort: String? ///Field to sort by; leading dash requests a reverse-order sort Values: distance, -distance, name, -name, country, -country, state, -state
    var limit: Int = 20 ///Maximum number of results to return Values:  (default: 20, max: 100)
    var page: Int = 1 ///Page of results to return Values: (default: 1)
}
