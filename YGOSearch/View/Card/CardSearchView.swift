//
//  CardSearchView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/28/23.
//

import SwiftUI

struct CardSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CardViewModel()

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("🔍 Search card", text: $searchText) {
                    viewModel.loadCardsData(searchText)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                List(viewModel.cards, id: \.id) { card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        Text(card.name)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(PlainListStyle())

                if viewModel.showError {
                    ErrorBanner(errorMessage: $viewModel.errorMessage, showError: $viewModel.showError)
                        .padding(.bottom)
                }
            }
            .navigationBarTitle("Search Menu", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 2) {
                    Image(systemName: "chevron.left.circle")
                    Text("Main Menu")
                }
                .foregroundColor(.blue)
            })
        }
    }
}
