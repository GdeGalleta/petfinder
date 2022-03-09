//
//  OrganizationsViewModelTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 9/3/22.
//

import XCTest
import Combine
@testable import Petfinder

class OrganizationsViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var apiProvider: ApiProviderType?
    private var viewModel: OrganizationsViewModelType?

    override func setUpWithError() throws {
        cancellables = []
        apiProvider = ApiProvider(session: TestsConstants.session)
        URLProtocol.registerClass(URLProtocolMock.self)

        viewModel = OrganizationsViewModel(apiProvider: apiProvider!)
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
            return (response, TestsConstants.organizationsJsonData)
        }

        let expectedModel = OrganizationModel(
            identifier: "NY1136",
            name: "Tuff Tails Animal Rescue",
            email: "info@tufftails.org",
            address: "P.O. Box 117 Levittown NY 11756 US")

        viewModel!.dataSourcePublisher
            .receive(on: RunLoop.main)
            .sink { response in
                let foundModel = response.filter({
                    return $0.identifier == expectedModel.identifier
                }).first
                if let model = foundModel {
                    XCTAssertEqual(model.identifier, expectedModel.identifier)
                    XCTAssertEqual(model.name, expectedModel.name)
                    XCTAssertEqual(model.email, expectedModel.email)
                    XCTAssertEqual(model.address, expectedModel.address)

                    expectation0.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel!.fetchOrganizations()

        wait(for: [expectation0], timeout: 5)
    }
}
