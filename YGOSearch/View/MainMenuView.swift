//
//  MainMenuView.swift
//  YGOSearch
//
//  Created by Efe Demir on 8/7/24.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var deckViewModel = DeckViewModel()
    @State private var showingNewDeckView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("YGOSearch")
                    .font(.largeTitle)
                    .padding()
                
                Image("yugioh-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
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
                    Text("Deck Management")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding()
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
