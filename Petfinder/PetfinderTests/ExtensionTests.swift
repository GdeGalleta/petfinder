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

    func test_colorValueForIndex() {
        var colorValue = UIColor.colorValueForIndex(0)
        XCTAssertEqual(colorValue, 0)
        colorValue = UIColor.colorValueForIndex(1)
        XCTAssertEqual(colorValue, 0.1)
        colorValue = UIColor.colorValueForIndex(10)
        XCTAssertEqual(colorValue, 1.0)
        colorValue = UIColor.colorValueForIndex(11)
        XCTAssertEqual(colorValue, 0.9)
        colorValue = UIColor.colorValueForIndex(20)
        XCTAssertEqual(colorValue, 0)
        colorValue = UIColor.colorValueForIndex(21)
        XCTAssertEqual(colorValue, 0.1)
    }
}
