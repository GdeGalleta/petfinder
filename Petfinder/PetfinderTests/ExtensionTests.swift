//
//  ExtensionTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest
import UIKit.UIColor

class ExtensionStringTests: XCTestCase {

    func test_stringToLocalized() {
        let expected = "Animals"
        let string = "kAnimals".localized
        XCTAssertEqual(string, expected)
    }
}

class ExtensionUIColorTests: XCTestCase {

    func test_randomColor() {
        var color = UIColor.random
        XCTAssertNotNil(color)
        color = UIColor.randomDark
        XCTAssertNotNil(color)
        color = UIColor.randomLight
        XCTAssertNotNil(color)
    }
}
