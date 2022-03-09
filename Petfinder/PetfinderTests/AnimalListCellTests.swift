//
//  AnimalListCellTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 9/3/22.
//

import XCTest
@testable import Petfinder

class AnimalListCellTests: XCTestCase {

    func test_instanceAndSetup() {
        let expectedUrl = URL(string: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/54890401/1/?bust=1646671398&width=600")
        let expectedImage = AnimalListPhotoModel(url: expectedUrl)
        let expectedModel = AnimalListModel(
            identifier: 54890401,
            name: "Ruby",
            age: "Adult",
            gender: "Female",
            size: "Medium",
            type: "Dog",
            distance: 0.1234,
            photo: expectedImage)

        let tableView = UITableView()
        tableView.register(AnimalListCell.self, forCellReuseIdentifier: AnimalListCell.identifier)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListCell.identifier, for: indexPath) as? AnimalListCell
        cell?.setup(with: expectedModel)
        cell?.cellColor = UIColor.colorForIndex(indexPath.row, overR: true)

        XCTAssertNotNil(cell)
    }
}
