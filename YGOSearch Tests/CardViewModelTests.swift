//
//  CardListViewModelTests.swift
//  YGOSearch Tests
//
//  Created by Efe Demir on 6/24/24.
//

import XCTest
@testable import YGOSearch
import Combine

class CardViewModelTests: XCTestCase {
    var sut: CardViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = CardViewModel(apiService: mockAPIService)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        mockAPIService = nil
        cancellables = []
        super.tearDown()
    }

    func testLoadCardDataSuccess() {
        let expectedCard = MockData.decodeMockCard(jsonString: MockData.blueEyesWhiteDragon)
        mockAPIService.cards = [expectedCard]

        let expectation = XCTestExpectation(description: "Card data loaded")
        sut.$cards
            .dropFirst()
            .sink { cards in
                XCTAssertEqual(cards.first?.name, expectedCard.name)
                XCTAssertEqual(cards.first?.atk, expectedCard.atk)
                XCTAssertEqual(cards.first?.def, expectedCard.def)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.loadAllCards()
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

        sut.loadAllCards()
        wait(for: [expectation], timeout: 1.0)
    }
}
