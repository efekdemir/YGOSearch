//
//  MainMenuView.swift
//  YGO Search
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

import SwiftUI

struct MainMenuView: View {
    @StateObject private var deckViewModel = DeckViewModel()
    @State private var showingNewDeckView = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text("YGO Search")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, geometry.safeAreaInsets.top)
                        .padding()

                    Image("yugioh-logo")
                        .resizable()
                        .scaledToFit()
                        .padding()

                    NavigationLink(destination: CardSearchView()) {
                        Text("Card Search")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()

                    NavigationLink(destination: DeckListView(viewModel: deckViewModel)) {
                        Text("Deck Editor")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding()

                    Spacer()

                    Text("Created by Efe Demir")
                        .frame(width: geometry.size.width, alignment: .center)
                        .font(.footnote)
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
            }
            .navigationBarItems(trailing: Button("Add Deck") {
                showingNewDeckView = true
            })
            .sheet(isPresented: $showingNewDeckView) {
                NewDeckView(isPresented: $showingNewDeckView) { name, description in
                    deckViewModel.createDeck(name: name, description: description)
                }
            }
        }
    }
}


#Preview {
    MainMenuView()
}
