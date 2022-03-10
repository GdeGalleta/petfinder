//
//  PetfinderUITests.swift
//  PetfinderUITests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest
@testable import Petfinder

class PetfinderUITests: XCTestCase {

    private let timeout = 5.0

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    private func runApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["testMode"]
        app.launch()
        return app
    }

    func test_animalList() {
        let app = runApp()

        _ = app.tabBars[K.AccessIden.tabBarStart].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tabBars[K.AccessIden.tabBarStart])

        // Open AnimalList
        app.buttons[K.AccessIden.tabBarButtonAnimalList].tap()

        _ = app.tables[K.AccessIden.tableAnimalList].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableAnimalList])

        _ = app.tables[K.AccessIden.tableCellAnimalList].firstMatch.waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableCellAnimalList].firstMatch)

        // Search animals by name
        var searchField = app.navigationBars[K.AccessIden.navigationBarAnimalList].searchFields.element
        searchField.tap()
        searchField.typeText("Max")
        app.buttons["Search"].tap()

        _ = app.tables[K.AccessIden.tableAnimalList].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableAnimalList])

        _ = app.tables[K.AccessIden.tableCellAnimalList].firstMatch.waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableCellAnimalList].firstMatch)

        // Filter animals by tape
        searchField = app.navigationBars[K.AccessIden.navigationBarAnimalList].searchFields.element
        searchField.tap()
        app.buttons["Dog"].tap()

        _ = app.tables[K.AccessIden.tableAnimalList].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableAnimalList])

        _ = app.tables[K.AccessIden.tableCellAnimalList].firstMatch.waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableCellAnimalList].firstMatch)

        // Reset search canceling
        searchField = app.navigationBars[K.AccessIden.navigationBarAnimalList].searchFields.element
        searchField.tap()
        app.buttons["Cancel"].tap()

        _ = app.tables[K.AccessIden.tableAnimalList].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableAnimalList])

        _ = app.tables[K.AccessIden.tableCellAnimalList].firstMatch.waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tables[K.AccessIden.tableCellAnimalList].firstMatch)
    }

    func test_organizations() {
        let app = runApp()

        _ = app.tabBars[K.AccessIden.tabBarStart].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.tabBars[K.AccessIden.tabBarStart])

        // Open AnimalList
        app.buttons[K.AccessIden.tabBarButtonOrganizations].tap()

        _ = app.maps[K.AccessIden.mapOrganizations].waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.maps[K.AccessIden.mapOrganizations])

        _ = app.maps[K.AccessIden.mapOrganizationsAnnotation].firstMatch.waitForExistence(timeout: timeout)
        XCTAssertNotNil(app.maps[K.AccessIden.mapOrganizationsAnnotation].firstMatch)
    }
}
