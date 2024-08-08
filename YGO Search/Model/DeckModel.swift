//
//  DeckModel.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import Foundation

struct DeckModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var cards: [CardModel]

    mutating func addCard(_ card: CardModel) {
        cards.append(card)
    }

    mutating func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}
