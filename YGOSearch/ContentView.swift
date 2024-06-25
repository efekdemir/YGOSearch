//
//  ContentView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CardListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a card", text: $searchText, onCommit: {
                    viewModel.loadCardData(searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Text("Name must be correctly written (i.e. Blue-Eyes White Dragon)")
                    .font(.footnote)

                if let card = viewModel.card {
                    CardView(card: card)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Search for a Yu-Gi-Oh card")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle(
                Text("Yu-Gi-Oh! Card Searcher")
                    .bold()
                    .font(.headline)
            )
        }
    }
}



#Preview {
    ContentView()
}
