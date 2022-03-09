//
//  PetfinderApiProviderTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest
import Combine
@testable import Petfinder

class PetfinderApiProviderTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var apiProvider: ApiProviderType?
    private var petfinderApiProvider: ApiProviderType?

    override func setUpWithError() throws {
        cancellables = []

        apiProvider = ApiProvider(session: TestsConstants.session)
        URLProtocol.registerClass(URLProtocolMock.self)

        if TestsConstants.isOfflineTest {
            petfinderApiProvider = PetfinderApiProviderMock(apiProvider: apiProvider!)
        } else {
            petfinderApiProvider = PetfinderApiProvider(apiProvider: apiProvider!)
        }
    }

    override func tearDownWithError() throws {
        apiProvider = nil
        petfinderApiProvider = nil
    }

    func test_fetchToken() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = PetfinderApiResource<PetfinderOAuthDto>.token()

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.tokenJsonData)
        }

        apiProvider!.fetch(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { (response: PetfinderOAuthDto) in
                if let accessToken = response.accessToken, !accessToken.isEmpty,
                   let tokenType = response.tokenType, !tokenType.isEmpty,
                   let expiresIn = response.expiresIn, expiresIn > 0 {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }

    func test_fetchAnimals() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = PetfinderApiResource<PetfinderAnimalsDto>.animals()

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.animalsJsonData)
        }

        petfinderApiProvider!.fetch(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { (response: PetfinderAnimalsDto) in
                if let animals = response.animals, !animals.isEmpty {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }

    func test_fetchOrganizations() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = PetfinderApiResource<PetfinderOrganizationsDto>.organizations()

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.organizationsJsonData)
        }

        petfinderApiProvider!.fetch(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { (response: PetfinderOrganizationsDto) in
                if let organizations = response.organizations, !organizations.isEmpty {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }

    func test_fetchTypes() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = PetfinderApiResource<PetfinderTypesDto>.organizations()

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.typesJsonData)
        }

        petfinderApiProvider!.fetch(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { (response: PetfinderTypesDto) in
                if let types = response.types, !types.isEmpty {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }
}
