//
//  TestsConstants.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 7/3/22.
//

import XCTest

public struct TestsConstants {
    private class Class {}

    static var isOfflineTest = true

    static var testsBundle: Bundle { return Bundle(for: TestsConstants.Class.self) }

    // MARK: - URLSession

    static let session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        if isOfflineTest {
            configuration.protocolClasses = [URLProtocolMock.self]
        }
        return URLSession(configuration: configuration)
    }()

    // MARK: - JSON

    static let sampleJsonData: Data = {
        return localFile(forResource: "sample", withExtension: "json")
    }()

    static let tokenJsonData: Data = {
        return localFile(forResource: "token", withExtension: "json")
    }()

    static let animalsJsonData: Data = {
        return localFile(forResource: "animals", withExtension: "json")
    }()

    static let organizationsJsonData: Data = {
        return localFile(forResource: "organizations", withExtension: "json")
    }()

    static let typesJsonData: Data = {
        return localFile(forResource: "types", withExtension: "json")
    }()

    static let petImage: Data = {
        return localFile(forResource: "pet", withExtension: "png")
    }()

    private static func localFile(forResource name: String?, withExtension ext: String?) -> Data {
        let fileUrl = testsBundle.url(forResource: name, withExtension: ext)
        guard let url = fileUrl, let data = try? Data(contentsOf: url) else {
            XCTFail("Error creating data from file")
            return Data()
        }
        return data
    }
}
