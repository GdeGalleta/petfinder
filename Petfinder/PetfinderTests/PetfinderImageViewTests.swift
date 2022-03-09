//
//  PetfinderImageViewTests.swift
//  PetfinderTests
//
//  Created by Dimitri Sopov on 9/3/22.
//

import XCTest
@testable import Petfinder

class PetfinderImageViewTests: XCTestCase {

    func test_marvelImageFromURL() {
        let expectation0 = expectation(description: "image loaded")

        let expected = UIImage(data: TestsConstants.petImage)
        let url = URL(string: "https://dl5zpyw5k3jeb.cloudfront.net/")!
        let imageView = UIImageViewMock()

        XCTAssertNil(imageView.image)

        imageView.load(url: url) {
            let data1 = imageView.image!.pngData()!
            let data2 = expected!.pngData()!
            if data1 == data2 {
                expectation0.fulfill()
            }
        }

        wait(for: [expectation0], timeout: 5)
    }

    private class UIImageViewMock: PetfinderImageView {

        override func loadImageData(url: URL) throws -> Data? {
            return TestsConstants.petImage
        }
    }
}
