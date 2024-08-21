//
//  MockAPIService.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/20/24.
//

import Combine
@testable import YGOSearch

class MockAPIService: APIServiceProtocol {
    var cards: [CardModel] = []
    var error: Error?

    func fetchAllCards() -> AnyPublisher<[CardModel], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(cards)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    func fetchCardsDetails(for name: String, typeFilter: String? = nil) -> AnyPublisher<[CardModel], Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            let filteredCards = cards.filter { card in
                (name.isEmpty || card.name.lowercased().contains(name.lowercased())) &&
                (typeFilter == nil || typeFilter!.split(separator: ",").contains { type in card.type.lowercased() == type.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
            }
            return Just(filteredCards)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
