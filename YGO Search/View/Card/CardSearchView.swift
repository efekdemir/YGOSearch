//
//  ContentView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/28/23.
//

import SwiftUI

struct CardSearchView: View {
    @ObservedObject var viewModel = CardViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Card Search")
                    .font(.title)
                    .bold()
                TextField("Search", text: $searchText, onCommit: {
                    viewModel.loadCardData(searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Text("Name must be correctly written")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                if let card = viewModel.card {
                    CardDetailView(card: card)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Try: Blue-Eyes White Dragon")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    CardSearchView()
}
