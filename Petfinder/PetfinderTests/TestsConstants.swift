//
//  TestsConstants.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest

public struct TestsConstants {
    private class Class {}
    static var testsBundle: Bundle { return Bundle(for: TestsConstants.Class.self) }

    static let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configuration)
    }()

    static let sampleJsonData: Data = {
        let fileUrl = testsBundle.url(forResource: "sample", withExtension: "json")
        guard let url = fileUrl, let data = try? Data(contentsOf: url) else {
            XCTFail("Error creating data from file")
            return Data()
        }
        return data
    }()
}
