//
//  APIServiceTests.swift
//  Master Duel Meta MobileTests
//
//  Created by Efe Demir on 6/24/24.
//

import XCTest
import Combine
@testable import YGOSearch

final class APIServiceTests: XCTestCase {
    var sut: APIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        sut = APIService()
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCardDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Successfully fetched card details from real API")

        sut.fetchCardDetails(for: "Blue-Eyes White Dragon")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error occurred: \(error)")
                }
            }, receiveValue: { card in
                XCTAssertEqual(card.name, "Blue-Eyes White Dragon")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchMockCardDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Successfully fetched card details from mock data")

        sut.fetchMockCardDetails()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error occurred: \(error)")
                }
            }, receiveValue: { card in
                XCTAssertEqual(card.name, "Blue-Eyes White Dragon")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchCardDetailsFailure() {
        let expectation = XCTestExpectation(description: "Properly handles the case where no card details are found")

        sut.fetchCardDetails(for: "Blue-Eyes Black Dragon")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Should have failed due to no card found")
                case .failure(let error):
                    XCTAssertTrue(error is DecodingError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Should not receive any card")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }
}


