//
//  DeckListView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct DeckListView: View {
    @ObservedObject var viewModel: DeckViewModel
    @State private var showingNewDeckView = false

    var body: some View {
        Text("Deck Editor")
            .font(.title)
        List {
            ForEach(viewModel.decks) { deck in
                NavigationLink(destination: DeckDetailView(deck: deck, viewModel: viewModel)) {
                    Text(deck.name)
                }
            }
            .onDelete(perform: viewModel.removeDeck)
        }
        .navigationBarItems(trailing: Button("Add Deck") {
            showingNewDeckView = true
        })
        .sheet(isPresented: $showingNewDeckView) {
            NewDeckView(isPresented: $showingNewDeckView) { name, description in
                viewModel.createDeck(name: name, description: description)
            }
        }
    }
}
