//
//  ContentView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CardViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("YGO Search")
                    .font(.title)
                    .bold()
                TextField("Search", text: $searchText, onCommit: {
                    viewModel.loadCardData(searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Text("Name must be correctly written (i.e. Blue-Eyes White Dragon)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                if let card = viewModel.card {
                    CardView(card: card)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Search for a card")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
