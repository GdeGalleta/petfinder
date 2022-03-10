//
//  AnimalListViewModelTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 9/3/22.
//

import XCTest
import Combine
@testable import Petfinder

class CharacterListViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var apiProvider: ApiProviderType?
    private var viewModel: AnimalListViewModelType?

    override func setUpWithError() throws {
        cancellables = []
        apiProvider = ApiProvider(session: TestsConstants.session)
        URLProtocol.registerClass(URLProtocolMock.self)

        viewModel = AnimalListViewModel(apiProvider: apiProvider!)
    }

    override func tearDownWithError() throws {
        apiProvider = nil
        viewModel = nil
    }

    func test_fetchAnimals() {
        let expectation0 = expectation(description: "expected values received")

        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "test.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.animalsJsonData)
        }

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

        viewModel!.dataSourcePublisher
            .receive(on: RunLoop.main)
            .sink { response in
                let foundModel = response.filter({
                    return $0.identifier == expectedModel.identifier
                }).first
                if let model = foundModel {
                    XCTAssertEqual(model.identifier, expectedModel.identifier)
                    XCTAssertEqual(model.name, expectedModel.name)
                    XCTAssertEqual(model.age, expectedModel.age)
                    XCTAssertEqual(model.gender, expectedModel.gender)
                    XCTAssertEqual(model.size, expectedModel.size)
                    XCTAssertEqual(model.type, expectedModel.type)
                    XCTAssertEqual(model.distance, expectedModel.distance)
                    XCTAssertEqual(model.photo!.url, expectedModel.photo!.url)

                    expectation0.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel!.fetchAnimals()

        wait(for: [expectation0], timeout: 5)
    }

    func test_fetchTypes() {
        let expectation0 = expectation(description: "expected values received")

        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "test.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.typesJsonData)
        }

        let expectedModel = ["All", "Dog", "Cat", "Rabbit", "Small & Furry", "Horse", "Bird", "Scales, Fins & Other", "Barnyard"].prefix(4)

        viewModel!.animalTypesPublisher
            .receive(on: RunLoop.main)
            .sink { response in
                var found = false
                for (index, type) in response.enumerated() where type != expectedModel[index] {
                    found = true
                    break
                }
                if !found {
                    expectation0.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel!.fetchTypes()

        wait(for: [expectation0], timeout: 5)
    }
}
