//
//  DeckDetailView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct DeckDetailView: View {
    var deck: DeckModel
    @ObservedObject var viewModel: DeckViewModel

    var body: some View {
        List {
            ForEach(deck.cards.indices, id: \.self) { index in
                Text(deck.cards[index].name)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.removeCardFromDeck(cardIndex: index, from: deck)
                }
            }
        }
    }
}
