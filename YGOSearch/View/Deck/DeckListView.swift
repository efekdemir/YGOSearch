//
//  DeckListView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct DeckListView: View {
    @ObservedObject var viewModel: DeckViewModel

    var body: some View {
        List {
            ForEach(viewModel.decks) { deck in
                NavigationLink(destination: DeckDetailView(deck: deck, viewModel: viewModel)) {
                    Text(deck.name)
                }
            }
            .onDelete(perform: viewModel.removeDeck) 
        }
        .navigationBarItems(trailing: Button("Add Deck") {
            viewModel.createDeck(name: "New Deck", description: "Describe your deck here...")
        })
        .navigationTitle("Decks")
    }
}

