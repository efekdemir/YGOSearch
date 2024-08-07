//
//  DeckViewModel.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/7/24.
//

import Foundation

class DeckViewModel: ObservableObject {
    @Published var decks: [DeckModel] = []

    func removeCardFromDeck(cardIndex: Int, from deck: DeckModel) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deck.id }) {
            decks[deckIndex].cards.remove(at: cardIndex)
        }
    }
    
    func createDeck(name: String, description: String) {
        let newDeck = DeckModel(name: name, description: description, cards: [])
        decks.append(newDeck)
    }

    func addCardToDeck(card: CardModel, deck: DeckModel) {
        if let index = decks.firstIndex(where: { $0.id == deck.id }) {
            decks[index].addCard(card)
        }
    }

    func removeDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }
}
