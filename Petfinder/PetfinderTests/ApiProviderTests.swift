//
//  ApiProviderTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest
import Combine
@testable import Petfinder

class ApiProviderTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    private var apiProvider: ApiProviderType?

    override func setUpWithError() throws {
        cancellables = []
        apiProvider = ApiProvider(session: TestsConstants.session)
        URLProtocol.registerClass(URLProtocolMock.self)
    }

    override func tearDownWithError() throws {
        apiProvider = nil
    }

    func test_fetchSample() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = ApiResource<Data>(baseURL: "test.com/", pathURL: "sample")

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.sampleJsonData)
        }

        apiProvider!.fetchData(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { response in
                if !response.isEmpty {
                    expectation1.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }

    func test_fetchSampleErrorInvalidURL() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = ApiResource<Data>(baseURL: "", pathURL: "")

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.sampleJsonData)
        }

        apiProvider!.fetchData(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        if error == .invalidURL {
                            expectation1.fulfill()
                        }
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { _ in
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }

    func test_fetchSampleErrorUnknownError() {
        let expectation0 = expectation(description: "call executed")
        let expectation1 = expectation(description: "expected values received")

        let resource = PetfinderApiResource<PetfinderTypesDto>.animals()

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: (resource.request?.url)!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, TestsConstants.sampleJsonData)
        }

        apiProvider!.fetch(resource: resource)
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        if error == ApiError.apiError(description: ApiError.unknown.errorDescription!) {
                            expectation1.fulfill()
                        }
                    case.finished:
                        break
                }
                expectation0.fulfill()
            } receiveValue: { (_: PetfinderTypesDto) in
            }
            .store(in: &cancellables)

        wait(for: [expectation0, expectation1], timeout: 5)
    }
}
