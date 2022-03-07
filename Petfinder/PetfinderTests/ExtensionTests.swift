//
//  ExtensionTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest

class ExtensionStringTests: XCTestCase {

    func test_stringToLocalized() {
        let expected = "Animals"
        let string = "kAnimals".localized
        XCTAssertEqual(string, expected)
    }
}
