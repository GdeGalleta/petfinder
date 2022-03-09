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

    func test_colorForIndex() {
        var expected = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        var color = UIColor.colorForIndex(1, overR: true, overG: true, overB: true)
        XCTAssertEqual(expected, color)
        expected = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        color = UIColor.colorForIndex(2, overR: true, overG: true, overB: true)
        XCTAssertEqual(expected, color)
        expected = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        color = UIColor.colorForIndex(11, overR: true, overG: true, overB: true)
        XCTAssertEqual(expected, color)
        expected = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        color = UIColor.colorForIndex(12, overR: true, overG: true, overB: true)
        XCTAssertEqual(expected, color)
    }
}

class ExtensionEncodable: XCTestCase {

    private struct EncodableClass: Codable {
        var foo = "foo"
        var bar = 123
    }

    func test_encodableToDictionary() {
        let encodable = EncodableClass()
        let dictionary = encodable.dictionary
        XCTAssertEqual(dictionary["foo"] as? String, encodable.foo)
        XCTAssertEqual(dictionary["bar"] as? Int, dictionary["bar"] as? Int)
    }

    func test_subscript() {
        let encodable = EncodableClass()
        let foo = encodable["foo"]
        let bar = encodable["bar"]
        XCTAssertEqual(foo as? String, encodable.foo)
        XCTAssertEqual(bar as? Int, encodable.bar)
    }
}

class ExtensionArray: XCTestCase {

    func test_removeDuplicates() {
        let expected = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        var array = [1, 1, 2, 2, 3, 2, 4, 5, 5, 5, 5, 6, 7, 8, 8, 8, 9]
        array.removeDuplicates()
        XCTAssertEqual(expected, array)
    }
}
