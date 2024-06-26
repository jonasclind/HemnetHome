//
//  HemnetHomeTests.swift
//  HemnetHomeTests
//
//  Created by Jonas Lind on 2024-05-06.
//

import XCTest
@testable import HemnetHome

final class HemnetHomeTests: XCTestCase {

    var viewModel: PropertyViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PropertyViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchHomes() {
        let expectation = self.expectation(description: "Fetches homes")

        viewModel.fetchProperties()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.area, "Area should not be nil")
            XCTAssertTrue(!self.viewModel.properties.isEmpty, "Properties should not be empty")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testFetchHomeDetails() {
        let expectation = self.expectation(description: "Fetches home details")

        viewModel.fetchPropertyDetails(for: "1234567890")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(self.viewModel.propertyDetails, "Home details should not be nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
