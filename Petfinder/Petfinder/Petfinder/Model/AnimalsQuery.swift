//
///  AnimalsQuery.swift
///  Petfinder
//
///  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

public struct AnimalsQuery: Encodable {
    var type: String? /// Return results matching animal type Values: Possible values may be looked up via Get Animal Types.
    var breed: String? /// Return results matching animal breed Values: Accepts multiple values, e.g. breed=pug,samoyed. Possible values may be looked up via Get Animal Breeds below.
    var size: String? /// Return results matching animal size Values: small, medium, large, xlarge Accepts multiple values, e.g. size=large,xlarge.
    var gender: String? /// Return results matching animal gender Values: male, female, unknown Accepts multiple values, e.g. gender=male,female.
    var age: String? /// Return results matching animal age Values: baby, young, adult, senior Accepts multiple values, e.g. age=baby,senior.
    var color: String? /// Return results matching animal color Values: Possible values may be looked up via Get Animal Types.
    var coat: String? /// Return results matching animal coat Values: short, medium, long, wire, hairless, curly Accepts multiple values, e.g. coat=wire,curly.
    var status: String? /// Return results matching adoption status Values: adoptable, adopted, found Accepts multiple values (default: adoptable)
    var name: String? /// Return results matching animal name (includes partial matches; e.g. "Fred" will return "Alfredo" and "Frederick")    string
    var organization: String? /// Return results associated with specific organization(s) Values: Accepts multiple values, e.g. organization=[ID1],[ID2].
    var good_with_children: Bool? /// Return results that are good with children Values: Can be true, false, 1, or 0
    var good_with_dogs: Bool? /// Return results that are good with dogs Values: Can be true, false, 1, or 0
    var good_with_cats: Bool? /// Return results that are good with cats Values: Can be true, false, 1, or 0
    var house_trained: Bool? /// Return results that are house trained Values: Can be true or 1 only
    var declawed: Bool? /// Return results that are declawed Values: Can be true or 1 only
    var special_needs: Bool? /// Return results that have special needs Values: Can be true or 1 only
    var location: String? /// Return results by location. Values: city, state; latitude,longitude; or postal code.
    var distance: Int? /// Return results within distance of location (in miles). Values: Requires location to be set (default: 100, max: 500)
    var before: String? /// Return results published before this date/time. Values: Must be a valid ISO8601 date-time string (e.g. 2019-10-07T19:13:01+00:00)
    var after: String? /// Return results published after this date/time. Values: Must be a valid ISO8601 date-time string (e.g. 2019-10-07T19:13:01+00:00)
    var sort: String? /// Attribute to sort by; leading dash requests a reverse-order sort Values: recent, -recent, distance, -distance, random (default: recent)
    var page: Int = 1 /// Specifies which page of results to return Values: (default: 1)
    var limit: Int = 20 /// Maximum number of results to return per 'page' response Values: (default: 20, max: 100)
}
