//
//  CardListViewModelTests.swift
//  Master Duel Meta MobileTests
//
//  Created by Efe Demir on 6/24/24.
//

import XCTest
@testable import YGOSearch
import Combine

class CardListViewModelTests: XCTestCase {
    var sut: CardListViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = CardListViewModel(apiService: mockAPIService)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        mockAPIService = nil
        cancellables = []
        super.tearDown()
    }

    func testLoadCardDataSuccess() {
        let expectedCard = createMockCardModel()
        mockAPIService.card = expectedCard

        let expectation = XCTestExpectation(description: "Card data loaded")
        sut.$card
            .dropFirst()
            .sink { card in
                XCTAssertEqual(card?.name, expectedCard.name)
                XCTAssertEqual(card?.type, expectedCard.type)
                XCTAssertEqual(card?.atk, expectedCard.atk)
                XCTAssertEqual(card?.def, expectedCard.def)
                XCTAssertEqual(card?.card_sets.first?.set_name, "Legend of Blue Eyes White Dragon")
                XCTAssertEqual(card?.card_images.first?.image_url, "https://example.com/image.png")
                XCTAssertEqual(card?.card_prices.first?.ebay_price, "6.00")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.loadCardData("Blue-Eyes White Dragon")
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadCardDataFailure() {
        let expectedError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch card"])
        mockAPIService.error = expectedError

        let expectation = XCTestExpectation(description: "Error message set")
        sut.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.loadCardData("Unknown Card")
        wait(for: [expectation], timeout: 1.0)
    }
}

